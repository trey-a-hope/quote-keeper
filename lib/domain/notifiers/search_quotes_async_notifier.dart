import 'dart:async';

import 'package:algoliasearch/algoliasearch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/domain/models/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class SearchQuotesAsyncNotifier
    extends AutoDisposeAsyncNotifier<List<BookModel>> {
  // Creating an instance of the search client with given App ID and API key.
  final SearchClient _client = SearchClient(
    appId: Globals.algolia.appId,
    apiKey: Globals.algolia.apiKey,
  );

  /// Debouncer for preventing search firing multiple times.
  Timer? _debounce;

  @override
  FutureOr<List<BookModel>> build() => [];

  // Update search, and perform search if search string present.
  void onSearchTextChanges(String query) {
    state = const AsyncLoading();

    /// Cancel debouncer if it's active.
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    /// Set new debouncer value.
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (query.isEmpty) {
          state = const AsyncData([]);
        } else {
          try {
            _performSearch(query);
          } catch (e) {
            state = AsyncError(e, StackTrace.current);
          }
        }
      },
    );
  }

  void _performSearch(String query) async {
    final uid = ref.read(Providers.authAsyncNotifierProvider.notifier).getUid();

    // Constructing a query to search for hits in the index.
    final SearchForHits queryHits = SearchForHits(
      indexName: Globals.algolia.booksIndex,
      query: query,
      hitsPerPage: 5,
      facetFilters: ['uid:$uid'],
    );

    // Execute the search request.
    final SearchResponse responseHits =
        await _client.searchIndex(request: queryHits);

    // Convert hits to list of book search results.
    final books = responseHits.hits
        .map(
          (hit) => BookModel(
            id: hit['id'],
            quote: hit['quote'],
            title: hit['title'],
            author: hit['author'],
            imgPath: hit['imgPath'],
            hidden: hit['hidden'],
            uid: hit['uid'],
            complete: hit['complete'],
            created: DateTime.fromMillisecondsSinceEpoch(hit['created']),
            modified: DateTime.fromMillisecondsSinceEpoch(hit['modified']),
          ),
        )
        .toList();

    state = AsyncData(books);
  }
}
