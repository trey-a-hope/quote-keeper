import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';

class SelectedBookSearchNotifier extends Notifier<SearchBooksResultModel?> {
  @override
  SearchBooksResultModel? build() => null;

  void setSearchBooksResult(SearchBooksResultModel searchBooksResultModel) {
    state = searchBooksResultModel;
  }
}
