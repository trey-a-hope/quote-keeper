import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareService extends GetxService {
  void share({required BookModel book}) {
    final text = '"${book.quote}"';
    final subject =
        'Here\'s one of my favorite quotes from ${book.title} by ${book.author}';

    Share.share(
      text,
      subject: subject,
    );
  }
}
