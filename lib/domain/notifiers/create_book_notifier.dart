import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class CreateBookNotifier extends Notifier<BookModel?> {
  final _getStorage = GetStorage();

  @override
  BookModel? build() {
    final searchBooksResultModel = ref.read(
      Providers.selectedBookSearchNotifierProvider,
    );

    if (searchBooksResultModel == null) {
      return null;
    }

    return BookModel(
      quote: '',
      title: searchBooksResultModel.title,
      author: searchBooksResultModel.author ?? 'Unknown Author',
      imgPath: searchBooksResultModel.imgUrl,
      hidden: false,
      uid: _getStorage.read('uid'),
      complete: false,
    );
  }

  void updateBook(BookModel bookModel) {
    state = bookModel;
  }

  void createBook() {
    debugPrint(state!.toString());
  }
}
