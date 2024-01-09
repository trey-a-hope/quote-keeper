import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';

// Book that is displayed on the Dashboard.
class DashboardBookAsyncNotifier extends AsyncNotifier<BookModel?> {
  static final _getStorage = GetStorage();
  final _bookService = BookService();
  final String _uid = _getStorage.read('uid');

  @override
  FutureOr<BookModel?> build() async {
    if (await _bookService.booksCollectionExists(uid: _uid)) {
      final book = await _bookService.getRandom(uid: _uid);
      return book;
    } else {
      return null;
    }
  }

  void setBook(BookModel book) {
    state = AsyncData(book);
  }

  Future<void> getRandomBook() async {
    if (await _bookService.booksCollectionExists(uid: _uid)) {
      final book = await _bookService.getRandom(uid: _uid);
      state = AsyncData(book);
    }
  }
}
