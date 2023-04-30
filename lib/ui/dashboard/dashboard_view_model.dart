import 'package:book_quotes/models/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardViewModel extends GetxController {
  final BookService _bookService = BookService();

  BookModel? book;

  @override
  void onInit() async {
    super.onInit();

    await _load();
  }

  Future _load() async {
    try {
      List<BookModel> books = await _bookService.list();
      book = books[0];
      update();
    } catch (e) {
      debugPrint('');
    }
  }
}
