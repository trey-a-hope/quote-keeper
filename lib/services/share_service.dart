import 'package:book_quotes/models/books/book_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  void share({required BookModel book}) {
    Share.share(
      book.quote,
      subject: '${book.title} by ${book.author}',
    );
  }
}
