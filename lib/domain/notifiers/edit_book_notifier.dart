import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quote_keeper/domain/models/books/book_model.dart';

// Updating of the book.
class EditBookNotifier extends Notifier<BookModel?> {
  @override
  BookModel? build() => null;

  void setBook(BookModel book) {
    state = book;
  }

  void deleteBook() {
    //TODO: Delete book in firestore.
    state = null;
  }
}
