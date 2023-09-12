import 'package:book_quotes/data/services/book_service.dart';
import 'package:book_quotes/data/cache/search_books_cache.dart';
import 'package:book_quotes/domain/models/search_books_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBooksRepository {
  final SearchBooksCache cache;

  final BookService _bookService = Get.find();

  SearchBooksRepository({required this.cache});
  Future<SearchBooksResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      try {
        final result = await _bookService.search(term: term);
        cache.set(term, result);
        return result;
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
      }
    }
  }
}
