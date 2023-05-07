import 'package:book_quotes/data/services/book_service.dart';
import 'package:book_quotes/domain/models/books/book_model.dart';
import 'package:get/get.dart';

class BooksViewModel extends GetxController {
  final BookService _bookService = BookService();

  List<BookModel> books = [];

  int? totalBookAccount;

  @override
  void onInit() async {
    update();

    load();
    super.onInit();
  }

  void load() async {
    try {
      books = await _bookService.list();
      totalBookAccount = await _bookService.getTotalBookCount();
      update();
    } catch (error) {
      throw Exception();
    }
  }
}
