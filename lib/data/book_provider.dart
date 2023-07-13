import 'dart:io';
import 'package:book_quotes/models/books/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:book_quotes/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class BookProvider extends ChangeNotifier {
  final BookService _bookService = BookService();
  final StorageService _storageService = StorageService();

  List<BookModel> books = [];

  int totalBookAccount = 0;

  final String uid = 'Rdi7d2Sv50MqTjLJ384jW44FSRz2';

  bool isLoading = false;

  BookProvider() {
    load();
  }

  void load() async {
    try {
      isLoading = true;
      notifyListeners();

      books = await _bookService.list(
        uid: uid,
      );

      totalBookAccount = await _bookService.getTotalBookCount(
        uid: uid,
      );

      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();

      throw Exception();
    }
  }

  Future createBook({
    required CroppedFile file,
    required String author,
    required String quote,
    required String title,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // Upload image to storage.
      String imgPath = await _storageService.uploadFile(
        file: File(file.path),
        path: 'users/$uid/books/$title',
      );

      // Create book model.
      BookModel book = BookModel(
        imgPath: imgPath,
        author: author,
        quote: quote,
        title: title,
        created: DateTime.now(),
        modified: DateTime.now(),
        hidden: false,
      );

      // Save book info to cloud firestore.
      await _bookService.create(
        uid: uid,
        book: book,
      );

      // Add new book to current state.
      books.add(book);
      totalBookAccount++;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future hideBook({required BookModel book}) async {
    try {
      // Update 'hidden' property on the BE.
      await _bookService.update(
        uid: uid,
        id: book.id!,
        data: {'hidden': true},
      );

      // Update 'hidden' property on the FE.
      books[books.indexOf(book)] = book.copyWith(hidden: true);

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future showBook({required BookModel book}) async {
    try {
      // Update 'hidden' property on the BE.
      await _bookService.update(
        uid: uid,
        id: book.id!,
        data: {'hidden': false},
      );

      // Update 'hidden' property on the FE.
      books[books.indexOf(book)] = book.copyWith(hidden: false);

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
