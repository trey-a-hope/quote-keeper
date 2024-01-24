import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';

// Total number of books for a user.
class QuotesAllTimeCountAsyncNotifier extends AutoDisposeAsyncNotifier<int> {
  final _bookService = BookService();

  @override
  Future<int> build() async {
    ref.watch(Providers.booksAsyncNotifierProvider);

    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();
    var count = await _bookService.getTotalBookCount(
      uid: uid,
    );
    return count;
  }
}
