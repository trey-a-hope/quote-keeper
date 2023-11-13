import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final GetStorage _getStorage = Get.find();

  BookModel? book;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  @override
  void onInit() async {
    super.onInit();
    await load();
  }

  Future load() async {
    try {
      var exists = await _bookService.booksCollectionExists(
        uid: _getStorage.read('uid'),
      );

      if (exists) {
        book = await _bookService.getRandom(
          uid: _getStorage.read('uid'),
        );
      }

      _isLoading = false;
      update();
    } catch (e) {
      debugPrint('');
    }
  }

  void updateBook({required BookModel newBook}) {
    book = newBook;
    update();
  }
}
