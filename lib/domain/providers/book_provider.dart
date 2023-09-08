import 'dart:io';
import 'package:book_quotes/data/services/share_service.dart';
import 'package:book_quotes/domain/models/books/book_model.dart';
import 'package:book_quotes/data/services/book_service.dart';
import 'package:book_quotes/data/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';

class BookProvider extends ChangeNotifier {
  final BookService _bookService = Get.find();
  final StorageService _storageService = Get.find();
  final ShareService _shareService = Get.find();
  final GetStorage _getStorage = Get.find();

  int totalBookAccount = 0;

  late String uid;

  bool isLoading = false;

  BookProvider() {
    uid = _getStorage.read('uid');
    load();
  }

  void load() async {
    try {
      isLoading = true;
      notifyListeners();

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

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future hideBook(
      {required BookModel book, required List<BookModel> books}) async {
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

  Future showBook(
      {required BookModel book, required List<BookModel> books}) async {
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

  Future shareBook({required BookModel book}) async {
    try {
      _shareService.share(
        book: book,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future deleteBook({required BookModel book}) async {
    try {
      // Delete book from firestore.
      await _bookService.delete(uid: uid, id: book.id!);

      // Delete image from storage.
      await _storageService.deleteFile(
        path: 'users/$uid/books/${book.title}',
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
