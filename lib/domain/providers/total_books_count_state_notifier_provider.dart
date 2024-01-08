import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/domain/notifiers/total_books_count_state_notifier.dart';

final totalBooksCountStateNotifierProvider =
    StateNotifierProvider<TotalBooksCountStateNotifier, int>(
  (ref) => TotalBooksCountStateNotifier(),
);
