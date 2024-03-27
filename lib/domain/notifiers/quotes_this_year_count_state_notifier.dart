// Total number of books for a user.
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class QuotesThisYearCountStateNotifier extends AutoDisposeAsyncNotifier<int> {
  final _bookService = BookService();

  @override
  Future<int> build() async {
    ref.watch(Providers.booksAsyncProvider);

    final uid = ref.read(Providers.authAsyncProvider.notifier).getUid();

    // Create date range for this month.
    final now = DateTime.now();

    var rangeStart = DateTime(now.year, 1, 1, 0, 0, 0);
    var rangeEnd = DateTime(now.year + 1, 1, 0, 0, 0);

    final count = await _bookService.getTotalBookCount(
      uid: uid,
      rangeStart: rangeStart,
      rangeEnd: rangeEnd,
    );

    return count;
  }
}
