import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/cache/search_books_cache.dart';
import 'package:quote_keeper/domain/models/search_books_result_model.dart';
import 'package:quote_keeper/domain/models/search_books_result.dart';
import 'package:quote_keeper/domain/repositories/search_books_repository.dart';

class SearchBooksAsyncNotifier
    extends AutoDisposeAsyncNotifier<List<SearchBooksResultModel>> {
  /// Repository for performing book search.
  final SearchBooksRepository searchBooksRepository = SearchBooksRepository(
    cache: SearchBooksCache(),
  );

  /// Debouncer for preventing search firing multiple times.
  Timer? _debounce;

  @override
  FutureOr<List<SearchBooksResultModel>> build() => [];

  void onSearchTextChanged(String val) async {
    state = const AsyncLoading();

    /// Cancel debouncer if it's active.
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    /// Set new debouncer value.
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (val.isEmpty) {
          state = const AsyncData([]);
        } else {
          try {
            /// Query search for books.
            final SearchBooksResult results =
                await searchBooksRepository.search(val);

            state = AsyncData(results.items);
          } catch (e) {
            state = AsyncError(e, StackTrace.current);
          }
        }
      },
    );
  }
}
