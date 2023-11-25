import 'package:algoliasearch/algoliasearch.dart';
import 'package:quote_keeper/data/services/share_service.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class BookProvider extends ChangeNotifier {
  // Initialize services.
  final BookService _bookService = Get.find();
  final UserService _userService = Get.find();
  final ShareService _shareService = Get.find();
  final GetStorage _getStorage = Get.find();

  // Total book, or "quote" count.
  int _totalBookAccount = 0;
  int get totalBookAccount => _totalBookAccount;

  // UID of current user.
  late String _uid;

  bool isLoading = false;

  // Search text.
  String _search = '';
  String get search => _search;

  // Quote for submission.
  String _quote = '';
  String get quote => _quote;

  // List of search results for books.
  List<BookModel> _bookSearchResults = [];
  List<BookModel> get bookSearchResults => _bookSearchResults;

  // Creating an instance of the search client with given App ID and API key.
  final SearchClient _client = SearchClient(
    appId: Globals.algolia.appId,
    apiKey: Globals.algolia.apiKey,
  );

  bool _showTutorial = false;
  bool get showTutorial => _showTutorial;

  BookProvider() {
    _uid = _getStorage.read('uid');
    // Determine if the tutorial should be shown.
    _showTutorial = !_getStorage.read(Globals.tutorialComplete);
    load();
  }

  // Update search, and perform search if search string present.
  void updateSearchText(String val) {
    _search = val;

    if (_search.isNotEmpty) {
      _performSearch();
    }

    notifyListeners();
  }

  void updateQuote(String val) {
    _quote = val;
    notifyListeners();
  }

  void _performSearch() async {
    // Constructing a query to search for hits in the index.
    final SearchForHits queryHits = SearchForHits(
      indexName: Globals.algolia.booksIndex,
      query: _search,
      hitsPerPage: 5,
      facetFilters: ['uid:$_uid'],
    );

    // Execute the search request.
    final SearchResponse responseHits =
        await _client.searchIndex(request: queryHits);

    // Convert hits to list of book search results.
    _bookSearchResults = responseHits.hits
        .map(
          (hit) => BookModel(
            id: hit['id'],
            quote: hit['quote'],
            title: hit['title'],
            author: hit['author'],
            imgPath: hit['imgPath'],
            hidden: hit['hidden'],
            complete: hit['complete'],
            uid: hit['uid'],
            created: DateTime.fromMillisecondsSinceEpoch(hit['created']),
            modified: DateTime.fromMillisecondsSinceEpoch(hit['modified']),
          ),
        )
        .toList();

    notifyListeners();
  }

  void load() async {
    try {
      isLoading = true;
      notifyListeners();

      _totalBookAccount = await _bookService.getTotalBookCount(
        uid: _uid,
      );

      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();

      throw Exception();
    }
  }

  Future createBook({
    required String? author,
    required String title,
    required String? imgUrl,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // Create book model.
      BookModel book = BookModel(
        imgPath: imgUrl,
        author: author ?? 'Author Unknown',
        quote: _quote,
        title: title,
        created: DateTime.now(),
        modified: DateTime.now(),
        hidden: false,
        complete: false,
        uid: _uid,
      );

      // Save book info to cloud firestore.
      await _bookService.create(
        book: book,
      );

      _totalBookAccount += 1;

      isLoading = false;

      // Set tutorialComplete flag to true. TODO: Maybe only update this once in the future?
      await _userService.updateUser(
        uid: _uid,
        data: {
          'tutorialComplete': true,
        },
      );

      // Turn off tutorial flag.
      _getStorage.write(Globals.tutorialComplete, true);

      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future hideBook({
    required BookModel book,
    required List<BookModel> books,
  }) async {
    try {
      // Update 'hidden' property on the BE.
      await _bookService.update(
        uid: _uid,
        id: book.id!,
        data: {'hidden': true},
      );

      // Update 'hidden' property on the FE.
      books[books.indexOf(book)] = book.copyWith(hidden: true);

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future showBook({
    required BookModel book,
    required List<BookModel> books,
  }) async {
    try {
      // Update 'hidden' property on the BE.
      await _bookService.update(
        uid: _uid,
        id: book.id!,
        data: {'hidden': false},
      );

      // Update 'hidden' property on the FE.
      books[books.indexOf(book)] = book.copyWith(hidden: false);

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future shareBook({required BookModel book}) async {
    try {
      _shareService.share(
        book: book,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future deleteBook({required BookModel book}) async {
    try {
      // Delete book from firestore.
      await _bookService.delete(uid: _uid, id: book.id!);

      _totalBookAccount -= 1;
    } catch (e) {
      throw Exception(e);
    }
  }
}
