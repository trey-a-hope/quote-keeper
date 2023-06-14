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

  BookProvider() {
    load();
  }

  void load() async {
    try {
      books = await _bookService.list(
        uid: uid,
      );
      totalBookAccount = await _bookService.getTotalBookCount(
        uid: uid,
      );
      notifyListeners();
    } catch (error) {
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
      );

      // Save book info to cloud firestore.
      await _bookService.create(
        uid: uid,
        book: book,
      );

      // Add new book to current state.
      books.add(book);
      totalBookAccount++;

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
