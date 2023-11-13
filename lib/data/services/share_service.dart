import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareService extends GetxService {
  void share({required BookModel book}) {
    Share.share(
      book.quote,
      subject: '${book.title} by ${book.author}',
    );
  }
}
