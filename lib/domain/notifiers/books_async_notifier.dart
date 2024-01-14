import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/data/services/firestore_book_service.dart';

// Paginated list of books for a user.
class BooksAsyncNotifier extends AsyncNotifier<List<BookModel>> {
  static final _getStorage = GetStorage();

  final _firestoreBookService = FirestoreBookService();

  final String _uid = _getStorage.read('uid');

  late DocumentSnapshot _lastDocument;

  @override
  FutureOr<List<BookModel>> build() async {
    state = const AsyncLoading();

    final data = await _firestoreBookService.getBooks(
      uid: _uid,
    );

    _lastDocument = data.docs.last;

    List<BookModel> books = _convertDataToBooks(data);

    return books;
  }

  void getNextBooks() async {
    try {
      state = const AsyncLoading();
      final data = await _firestoreBookService.getBooks(
        uid: _uid,
        lastDocument: _lastDocument,
      );
      _lastDocument = data.docs.last;
      List<BookModel> books = _convertDataToBooks(data);
      state = AsyncData([...state.value!, ...books]);
    } catch (e) {
      if (e is StateError) {
      } else {
        rethrow;
      }
    }
  }

  // Converts a querysnapshot into an array of books.
  List<BookModel> _convertDataToBooks(QuerySnapshot<Object?> o) => o.docs
      .map(
        (doc) => doc.data() as BookModel,
      )
      .toList();

  Future<void> updateBook({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    var books = state.value!;

    // Get index of book by id.
    var index = books.indexWhere((book) => book.id == id);

    // If the book is not in the list yet, then return.
    if (index < 0) return;

    books[index] = books[index].copyWith(
      quote: data['quote'],
      hidden: data['hidden'],
      complete: data['complete'],
    );

    state = AsyncData(books);
  }
}
