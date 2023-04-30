import 'dart:io';

import 'package:book_quotes/models/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage_wrapper/firebase_storage_wrapper.dart';

class CreateBookViewModel extends GetxController {
  final BookService _bookService = BookService();

  String? imgPath;

  @override
  void onInit() async {
    super.onInit();

    update();
  }

  Future create({
    required String author,
    required String quote,
    required String title,
  }) async {
    if (imgPath == null) {
      throw Exception('Must select image first.');
    }
    try {
      await _bookService.create(
        book: BookModel(
          imgPath: imgPath!,
          author: author,
          quote: quote,
          title: title,
          createdAt: DateTime.now(),
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

      File? image = await ImageCropper().cropImage(sourcePath: file.path);

      if (image == null) return;

      imgPath = await FirebaseStorageWrapper.uploadFile(
        file: image,
        path: 'BookQuotes/Books/$bookTitle',
      );

      update();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
