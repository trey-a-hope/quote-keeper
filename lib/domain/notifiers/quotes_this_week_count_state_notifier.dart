// Total number of books for a user.
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class QuotesThisWeekCountStateNotifier extends AutoDisposeAsyncNotifier<int> {
  final _bookService = BookService();

  @override
  Future<int> build() async {
    ref.watch(Providers.booksAsyncProvider);

    final uid = ref.read(Providers.authAsyncProvider.notifier).getUid();

    // Create date range for this month.
    final now = DateTime.now();

    var rangeStart = now.subtract(Duration(days: now.weekday - 1));
    var rangeEnd = now.add(Duration(days: 7 - now.weekday));

    final count = await _bookService.getTotalBookCount(
      uid: uid,
      rangeStart: rangeStart,
      rangeEnd: rangeEnd,
    );

    return count;
  }
}
