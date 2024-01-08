import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/notifiers/books_state_notifier.dart';

final booksStateNotifierProvider =
    StateNotifierProvider<BooksStateNotifier, List<BookModel>>(
  (ref) => BooksStateNotifier(),
);
