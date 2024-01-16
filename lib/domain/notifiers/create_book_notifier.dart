import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

// Creating of the book or "quote".
class CreateBookNotifier extends AutoDisposeNotifier<BookModel?> {
  final _bookService = BookService();

  @override
  BookModel? build() => BookModel(
        quote: '',
        title: '',
        author: '',
        imgPath: '',
        hidden: false,
        uid: ref.read(Providers.authAsyncNotifierProvider.notifier).getUid(),
        complete: false,
        created: DateTime.now(),
        modified: DateTime.now(),
      );

  void updateBook(BookModel bookModel) {
    state = bookModel;
  }

  Future<void> createBook(SearchBooksResultModel searchBooksResultModel) async {
    final book = state!;

    final newBook = BookModel(
      quote: book.quote,
      title: searchBooksResultModel.title,
      author: searchBooksResultModel.author ?? 'Unknown Author',
      imgPath: searchBooksResultModel.imgUrl,
      hidden: book.hidden,
      created: DateTime.now(),
      modified: DateTime.now(),
      uid: book.uid,
      complete: book.complete,
    );

    // Add book to BE.
    final id = await _bookService.create(newBook);

    // Add book to FE.
    ref
        .read(Providers.booksAsyncNotifierProvider.notifier)
        .addBook(newBook.copyWith(id: id));

    // Set new book as dashboard default.
    ref
        .read(Providers.dashboardBookAsyncNotifierProvider.notifier)
        .setBook(newBook);
  }
}
