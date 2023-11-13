import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditBookViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final GetStorage _getStorage = Get.find();

  final BookModel book = Get.arguments['book'];

  @override
  void onInit() async {
    super.onInit();

    update();
  }

  Future updateQuote({
    required String quote,
  }) async {
    try {
      await _bookService.update(
        uid: _getStorage.read('uid'),
        id: book.id!,
        data: {
          'quote': quote,
        },
      );
    } catch (error) {
      debugPrint(error.toString());
      throw Exception(error);
    }
  }
}
