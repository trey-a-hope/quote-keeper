import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditBookViewModel extends GetxController {
  final _bookService = BookService();
  final _getStorage = GetStorage();

  bool _isHidden = false;
  bool get isHidden => _isHidden;

  bool _isComplete = false;
  bool get isComplete => _isComplete;

  BookModel _book = Get.arguments['book'];
  BookModel get book => _book;

  @override
  void onInit() async {
    super.onInit();

    _isHidden = _book.hidden;
    _isComplete = _book.complete;

    update();
  }

  void toggleIsHidden(bool val) {
    _isHidden = !val; // Negating here to have appropriate view on view.
    update();
  }

  void toggleIsComplete(bool val) {
    _isComplete = val;
    update();
  }

  Future updateQuote({
    required String quote,
  }) async {
    // Udpdate book on the backend.
    await _bookService.update(
      id: _book.id!,
      data: {
        'quote': quote,
        'hidden': _isHidden,
        'complete': _isComplete,
      },
    );

    // Update book locally.
    _book = BookModel(
      id: _book.id!,
      quote: quote,
      title: _book.title,
      author: _book.author,
      imgPath: _book.imgPath,
      hidden: _isHidden,
      uid: _book.uid,
      complete: _isComplete,
    );

    update();
  }

  Future deleteQuote() async => await _bookService.delete(
        uid: _getStorage.read('uid'),
        id: _book.id!,
      );
}
