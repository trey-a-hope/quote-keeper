import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/cache/search_books_cache.dart';
import 'package:quote_keeper/domain/models/search_books_result.dart';

class SearchBooksRepository {
  final SearchBooksCache cache;

  final _bookService = BookService();

  SearchBooksRepository({required this.cache});
  Future<SearchBooksResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      final result = await _bookService.searchGoogleBooks(term: term, limit: 5);
      cache.set(term, result);
      return result;
    }
  }
}
