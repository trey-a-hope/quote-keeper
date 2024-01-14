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

  void reset() {
    state = const AsyncData(null);
  }

  // Sets the book to the given book.
  void setBook(BookModel book) {
    state = AsyncData(book);
  }

  // Fetches a random book for the user.
  Future<void> getRandomBook() async {
    // Validate there is at least one book in the users' collection.
    if (await _bookService.booksCollectionExists(uid: _uid)) {
      // Set book to random book in collection.
      final book = await _bookService.getRandom(uid: _uid);
      state = AsyncData(book);
    } else {
      // Otherwise, set book to null.
      state = const AsyncData(null);
    }
  }
}
