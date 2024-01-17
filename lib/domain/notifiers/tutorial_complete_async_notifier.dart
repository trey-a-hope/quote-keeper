import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';

// Whether or not to display the tutorial.
class TutorialCompleteAsyncNotifier extends AutoDisposeAsyncNotifier<bool> {
  final _bookService = BookService();

  @override
  FutureOr<bool> build() async {
    ref.watch(Providers.booksAsyncNotifierProvider);

    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();

    // Assume that if a user has added a book, they've completed the tutorial.
    final exists = await _bookService.booksCollectionExists(uid: uid);

    return exists;
  }
}
