import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the value of wether the search is descending or not.
class BookSearchIsDescendingNotifier extends AutoDisposeNotifier<bool> {
  @override
  bool build() => true;

  void toggle() => state = !state;
}
