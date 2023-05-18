import 'dart:io';

import 'package:book_quotes/data/services/storage_service.dart';
import 'package:book_quotes/domain/models/books/book_model.dart';
import 'package:book_quotes/data/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateBookViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final StorageService _storageService = Get.find();

  CroppedFile? selectedCroppedFile;

  Future create({
    required String author,
    required String quote,
    required String title,
  }) async {
    if (selectedCroppedFile == null) {
      throw Exception('Must select image first.');
    }
    try {
      // Upload image to storage.
      String imgPath = await _storageService.uploadFile(
        file: File(selectedCroppedFile!.path),
        path: 'BookQuotes/Books/$title',
      );

      // Save book info to cloud firestore.
      await _bookService.create(
        book: BookModel(
          imgPath: imgPath,
          author: author,
          quote: quote,
          title: title,
          createdAt: DateTime.now(),
          modified: DateTime.now(),
        ),
      );
    } catch (error) {
      debugPrint(error.toString());
      throw Exception(error);
    }
  }

  void updateImage(
      {required ImageSource imageSource, required String bookTitle}) async {
    try {
      XFile? file = await ImagePicker().pickImage(source: imageSource);

      if (file == null) return;

      CroppedFile? croppedFile =
          await ImageCropper().cropImage(sourcePath: file.path);

      if (croppedFile == null) return;

      selectedCroppedFile = croppedFile;

      update();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
