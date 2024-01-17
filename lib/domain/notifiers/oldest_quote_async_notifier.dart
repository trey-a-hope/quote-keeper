import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class OldestQuoteAsyncNotifier extends AutoDisposeAsyncNotifier<BookModel?> {
  final _bookService = BookService();

  @override
  FutureOr<BookModel?> build() async {
    // Watch for changes to the BooksAsyncNotifierProvider.
    ref.watch(Providers.booksAsyncNotifierProvider);

    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();
    final exists = await _bookService.booksCollectionExists(uid: uid);
    if (exists) {
      var book = await _bookService.getOldestQuote(uid: uid);
      return book;
    } else {
      return null;
    }
  }
}
