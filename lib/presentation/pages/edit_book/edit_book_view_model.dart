import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditBookViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final GetStorage _getStorage = Get.find();

  final BookModel book = Get.arguments['book'];

  bool _isHidden = false;
  bool get isHidden => _isHidden;

  bool _isComplete = false;
  bool get isComplete => _isComplete;

  @override
  void onInit() async {
    super.onInit();

    _isHidden = book.hidden;
    _isComplete = book.complete;

    update();
  }

  void toggleIsHidden(bool val) {
    _isHidden = val;
    update();
  }

  void toggleIsComplete(bool val) {
    _isComplete = val;
    update();
  }

  Future updateQuote({
    required String quote,
  }) async =>
      await _bookService.update(
        uid: _getStorage.read('uid'),
        id: book.id!,
        data: {
          'quote': quote,
          'hidden': _isHidden,
          'complete': _isComplete,
        },
      );

  Future deleteQuote() async => await _bookService.delete(
        uid: _getStorage.read('uid'),
        id: book.id!,
      );
}
