import 'package:book_quotes/search_books/search_books_result.dart';

class SearchBooksCache {
  final _cache = <String, SearchBooksResult>{};

  SearchBooksResult get(String term) => _cache[term]!;

  void set(String term, SearchBooksResult result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
