import 'package:book_quotes/data/services/book_service.dart';
import 'package:book_quotes/domain/models/books/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBookViewModel extends GetxController {
  EditBookViewModel();

  final BookService _bookService = Get.find();

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
