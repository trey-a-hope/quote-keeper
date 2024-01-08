import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';

// Book that is displayed on the Dashboard.
class DashboardBookStateNotifier extends StateNotifier<BookModel?> {
  final GetStorage _getStorage = Get.find();
  final BookService _bookService = Get.find();

  late String _uid;

  DashboardBookStateNotifier() : super(null) {
    _uid = _getStorage.read('uid');
    getRandomBook();
  }

  void setBook(BookModel book) {
    state = book;
  }

  Future<void> getRandomBook() async {
    if (await _checkIfBooksCollectionExists()) {
      final book = await _bookService.getRandom(uid: _uid);
      state = book;
    }
  }

  Future<bool> _checkIfBooksCollectionExists() async =>
      await _bookService.booksCollectionExists(
        uid: _uid,
      );
}
