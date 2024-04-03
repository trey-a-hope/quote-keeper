import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the value of whether the search results are descending or not.
class BookSearchIsDescendingNotifier extends AutoDisposeNotifier<bool> {
  // Default isDescending to true.
  @override
  bool build() => true;

  // Update to the inverse of its current value.
  void toggle() => state = !state;
}
