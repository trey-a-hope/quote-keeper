import 'package:quote_keeper/domain/models/search_books_result_model.dart';

class SearchBooksResult {
  final List<SearchBooksResultModel> items;

  const SearchBooksResult({required this.items});

  static SearchBooksResult fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map(
          (dynamic item) => SearchBooksResultModel(
            author: item['volumeInfo']['authors']?[0],
            description: item['volumeInfo']['description'],
            id: item['id'],
            imgUrl: item['volumeInfo']['imageLinks']?['thumbnail'],
            title: item['volumeInfo']['title'],
          ),
        )
        .toList();
    return SearchBooksResult(items: items);
  }
}
