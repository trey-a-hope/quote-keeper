import 'package:book_quotes/models/books/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BooksViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final GetStorage _getStorage = Get.find();

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
      books = await _bookService.list(
        uid: _getStorage.read('uid'),
      );
      totalBookAccount = await _bookService.getTotalBookCount();
      update();
    } catch (error) {
      throw Exception();
    }
  }
}
