import 'package:book_quotes/models/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardViewModel extends GetxController {
  final BookService _bookService = BookService();

  BookModel? book;

  @override
  void onInit() async {
    super.onInit();

    await load();
  }

  Future load() async {
    try {
      book = await _bookService.getRandom();
      update();
    } catch (e) {
      debugPrint('');
    }
  }
}
