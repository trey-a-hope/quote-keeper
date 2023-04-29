import 'dart:io';

import 'package:book_quotes/models/quote_model.dart';
import 'package:book_quotes/services/quote_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage_wrapper/firebase_storage_wrapper.dart';

class CreateQuoteViewModel extends GetxController {
  final GetStorage _getStorage = GetStorage();
  final QuoteService _quoteService = QuoteService();

  String? imgPath;

  @override
  void onInit() async {
    super.onInit();

    update();
  }

  Future createQuote({
    required String author,
    required String quote,
    required String bookTitle,
  }) async {
    if (imgPath == null) {
      throw Exception('Must select image first.');
    }
    try {
      await _quoteService.createQuote(
        quote: QuoteModel(
          imgPath: imgPath!,
          author: author,
          quote: quote,
          bookTitle: bookTitle,
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

      // await _userService.updateUser(
      //   uid: uid,
      //   data: {
      //     'imgUrl': newImgUrl,
      //   },
      // );

      // user = await _userService.retrieveUser(uid: uid);

      update();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
