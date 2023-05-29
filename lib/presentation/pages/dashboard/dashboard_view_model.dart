import 'package:book_quotes/models/books/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final GetStorage _getStorage = Get.find();

  BookModel? book;

  @override
  void onInit() async {
    super.onInit();

    await load();
  }

  Future load() async {
    try {
      book = await _bookService.getRandom(uid: _getStorage.read('uid'));
      update();
    } catch (e) {
      debugPrint('');
    }
  }
}
