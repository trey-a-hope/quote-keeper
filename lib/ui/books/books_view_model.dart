import 'package:book_quotes/models/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:get/get.dart';

class BooksViewModel extends GetxController {
  final BookService _bookService = BookService();

  List<BookModel> books = [];

  @override
  void onInit() async {
    update();

    load();
    super.onInit();
  }

  void load() async {
    try {
      books = await _bookService.list();
      update();
    } catch (error) {
      throw Exception();
    }
  }
}
