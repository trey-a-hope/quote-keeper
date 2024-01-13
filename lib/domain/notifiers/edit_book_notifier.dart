import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';

// Updating of the book.
class EditBookNotifier extends Notifier<BookModel?> {
  final _bookService = BookService();
  final _getStorage = GetStorage();

  @override
  BookModel? build() => null;

  void setBook(BookModel book) {
    state = book;
  }

  void saveBook() async {
    var book = state!;

    _bookService.update(
      id: book.id!,
      data: {
        'quote': book.quote,
        'hidden': book.hidden,
        'complete': book.complete,
      },
    );

    //TODO: Need to update the book in the BooksAsyncNotifier to see changes on previous screen.
  }

  void deleteBook() async {
    var book = state;

    if (book == null) {
      throw Exception('Book not set yet.');
    }

    await _bookService.delete(
      uid: _getStorage.read('uid'),
      id: book.id!,
    );

    state = null;
  }
}
