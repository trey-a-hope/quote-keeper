import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/data/cache/search_books_cache.dart';
import 'package:quote_keeper/domain/repositories/search_books_repository.dart';
import 'package:quote_keeper/domain/models/search_books_result.dart';

class SearchBooksViewModel extends GetxController {
  /// Book results.
  List<SearchBooksResultModel> books = [];

  /// Repository for performing book search.
  final SearchBooksRepository searchBooksRepository = SearchBooksRepository(
    cache: SearchBooksCache(),
  );

  /// Debouncer for preventing search firing multiple times.
  Timer? _debounce;

  /// Deterimines if loading indicator is present.
  bool isLoading = false;

  /// Error message when searching.
  String? errorMessage;

  @override
  void onInit() async {
    super.onInit();
    await load();
  }

  Future load() async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onClose() async {
    _debounce?.cancel();
    super.onClose();
  }

  void udpateSearchText({required String text}) async {
    /// Display loading indicator.
    isLoading = true;

    /// Clear error message.
    errorMessage = null;

    update();

    /// Cancel debouncer if it's active.
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    /// Set new debouncer value.
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (text.isEmpty) {
          /// Return empty array of results.
          books = [];

          /// Clear loading indicator.
          isLoading = false;

          update();
        } else {
          try {
            /// Attempt to search for books.
            final SearchBooksResult results =
                await searchBooksRepository.search(text);

            /// Extract books from result.
            books = results.items;

            /// Clear loading indicator.
            isLoading = false;

            update();
          } catch (e) {
            /// Set error message.
            errorMessage = e.toString();

            /// Clear loading indicator.
            isLoading = false;

            update();
          }
        }
      },
    );
  }
}
