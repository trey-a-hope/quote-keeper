import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';

// Total number of books for a user.
class TotalBooksCountAsyncNotifier extends AutoDisposeAsyncNotifier<int> {
  final _bookService = BookService();

  @override
  Future<int> build() async {
    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();
    var count = await _bookService.getTotalBookCount(uid: uid);
    return count;
  }

  void increment() {
    if (state.value == null) {
      state = const AsyncData(0);
    }

    final val = state.value!;

    state = AsyncData(val + 1);
  }

  void decrement() {
    if (state.value == null) {
      state = const AsyncData(0);
    }

    final val = state.value!;

    if (val > 0) {
      state = AsyncData(val - 1);
    }
  }
}
