import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class MostRecentQuotesAsyncNotifier
    extends AutoDisposeAsyncNotifier<List<BookModel>?> {
  final _bookService = BookService();

  @override
  FutureOr<List<BookModel>?> build() async {
    // Watch for changes to the BooksAsyncNotifierProvider.
    ref.watch(Providers.booksAsyncNotifierProvider);

    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();
    final exists = await _bookService.booksCollectionExists(uid: uid);
    if (exists) {
      final books = await _bookService.getNewestQuotes(uid: uid, limit: 3);
      return books;
    } else {
      return null;
    }
  }
}
