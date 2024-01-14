import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

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

    // Update book on BE.
    await _bookService.update(
      id: book.id!,
      data: {
        'quote': book.quote,
        'hidden': book.hidden,
        'complete': book.complete,
      },
    );

    // Update book on FE.
    await ref.read(Providers.booksAsyncNotifierProvider.notifier).updateBook(
      id: book.id!,
      data: {
        'quote': book.quote,
        'hidden': book.hidden,
        'complete': book.complete,
      },
    );
  }

  void deleteBook(BuildContext context) async {
    var book = state!;

    // Delete book on BE.
    await _bookService.delete(
      uid: _getStorage.read('uid'),
      id: book.id!,
    );

    // Update book on FE.
    await ref.read(Providers.booksAsyncNotifierProvider.notifier).deleteBook(
          id: book.id!,
        );

    // Decrement total book count.
    ref
        .read(Providers.totalBooksCountStateNotifierProvider.notifier)
        .decrement();

    // If deleted book is on dashboard, fetch new random book.
    if (ref.read(Providers.dashboardBookAsyncNotifierProvider).value!.id ==
        book.id!) {
      ref
          .read(Providers.dashboardBookAsyncNotifierProvider.notifier)
          .getRandomBook();
    }

    if (!context.mounted) return;

    // Return to the books page.
    context.pop();
  }
}
