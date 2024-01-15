import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

// Book that is displayed on the Dashboard.
class DashboardBookAsyncNotifier extends AutoDisposeAsyncNotifier<BookModel?> {
  final _bookService = BookService();

  @override
  FutureOr<BookModel?> build() async {
    final uid =
        ref.watch(Providers.authAsyncNotifierProvider.notifier).getUid();

    if (await _bookService.booksCollectionExists(uid: uid)) {
      final book = await _bookService.getRandom(uid: uid);
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
    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();

    // Validate there is at least one book in the users' collection.
    if (await _bookService.booksCollectionExists(uid: uid)) {
      // Set book to random book in collection.
      final book = await _bookService.getRandom(uid: uid);
      state = AsyncData(book);
    } else {
      // Otherwise, set book to null.
      state = const AsyncData(null);
    }
  }
}
