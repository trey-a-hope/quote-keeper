import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

// Paginated list of books for a user.
class BooksAsyncNotifier extends AutoDisposeAsyncNotifier<List<BookModel>> {
  final _bookService = BookService();

  late DocumentSnapshot _lastDocument;

  @override
  FutureOr<List<BookModel>> build() async {
    state = const AsyncLoading();

    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();

    final exists = await _bookService.booksCollectionExists(uid: uid);

    if (!exists) {
      return [];
    }

    final querySnapshot = await _bookService.getBooks(uid: uid, limit: 5);

    _lastDocument = querySnapshot.docs.last;

    List<BookModel> books = _convertQuerySnapshotToBooks(querySnapshot);

    return books;
  }

  void getNextBooks() async {
    try {
      state = const AsyncLoading();

      final querySnapshot = await _bookService.getBooks(
        uid: ref.read(Providers.authAsyncNotifierProvider.notifier).getUid(),
        lastDocument: _lastDocument,
        limit: 10,
      );

      _lastDocument = querySnapshot.docs.last;

      List<BookModel> books = _convertQuerySnapshotToBooks(querySnapshot);

      state = AsyncData([...state.value!, ...books]);
    } catch (e) {
      if (e is StateError) {
      } else {
        rethrow;
      }
    }
  }

  Future<void> updateBook({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    // Update book on BE.
    await _bookService.update(
      id: id,
      data: {
        'quote': data['quote'],
        'hidden': data['hidden'],
        'complete': data['complete'],
      },
    );

    // Update book on FE.
    var books = state.value!;

    // Get index of book by id.
    var index = books.indexWhere((book) => book.id == id);

    // If the book is not in the list yet, then return.
    if (index < 0) return;

    books[index] = books[index].copyWith(
      quote: data['quote'],
      hidden: data['hidden'],
      complete: data['complete'],
    );

    state = AsyncData(books);
  }

  // Delete the book.
  Future<void> deleteBook({
    required String id,
    required BuildContext context,
  }) async {
    // Delete book on BE.
    await _bookService.delete(id: id);

    var books = state.value!;

    // Get index of book by id.
    var index = books.indexWhere((book) => book.id == id);

    // If the book is not in the list yet, then return.
    if (index < 0) return;

    // Delete book on the FE.
    books.removeAt(index);

    state = AsyncData(books);

    if (!context.mounted) return;

    context.pop();
  }

  // Add the book on the FE.
  Future<void> addBook(BookModel newBook) async {
    var books = <BookModel>[];

    if (state.hasValue) {
      books = state.value!;
    }

    // If the book is not in the list yet, add it at the top.
    books.insert(0, newBook);

    state = AsyncData(books);
  }

  // Converts a querysnapshot into an array of books.
  List<BookModel> _convertQuerySnapshotToBooks(QuerySnapshot<Object?> o) =>
      o.docs
          .map(
            (doc) => doc.data() as BookModel,
          )
          .toList();
}
