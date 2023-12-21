import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter_filter_dialog/flutter_filter_dialog.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/providers/book_provider.dart';
import 'package:quote_keeper/domain/providers/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:quote_keeper/presentation/widgets/book/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class BooksScreen extends ConsumerWidget {
  final PagingController<int, BookModel> _defaultPagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, BookModel> _completePagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, BookModel> _incompletePagingController =
      PagingController(firstPageKey: 0);

  BooksScreen({Key? key}) : super(key: key) {
    _defaultPagingController
        .addPageRequestListener((pageKey) => _defaultFetchPage(pageKey));

    _completePagingController
        .addPageRequestListener((pageKey) => _completeFetchPage(pageKey));

    _incompletePagingController
        .addPageRequestListener((pageKey) => _incompleteFetchPage(pageKey));
  }

  String? _lastTitle;

  final BookService _bookService = Get.find();
  final GetStorage _getStorage = Get.find();
  final ModalService _modalService = Get.find();

  final List<S2Choice<int>> _filterOptions = [
    S2Choice<int>(value: 0, title: FilterOptions.complete.name),
    S2Choice<int>(value: 1, title: FilterOptions.incomplete.name),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BookProvider bookProvider = ref.watch(Providers.bookProvider);

    return SimplePageWidget(
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Get.back(result: false);
        },
      ),
      title: 'Books - ${bookProvider.totalBookAccount}',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimatedSearchBar(
              label: 'Search Your Favorite Quotes',
              onChanged: (value) => bookProvider.updateSearchText(value),
              textInputAction: TextInputAction.done,
            ),
          ),
          SmartSelect<int>.multiple(
            modalConfig: const S2ModalConfig(
              title: 'Filters',
              type: S2ModalType.bottomSheet,
            ),
            title: 'Filters',
            choiceItems: _filterOptions,
            onChange: (state) {
              if (state != null) {
                if (state.choice!.isEmpty) {
                  // If no filter option was selected, clear the filter.
                  bookProvider.updateFilterOption(null);
                } else {
                  // If more than one filter option was selected, prompt user of error.
                  if (state.choice!.length > 1) {
                    _modalService.showAlert(
                      context: context,
                      title: 'Error',
                      message: 'Cannot select both options.',
                    );

                    // Reset the filter option to the previous selection.
                    if (bookProvider.selectedFilterOption != null) {
                      switch (bookProvider.selectedFilterOption!.name) {
                        case 'complete':
                          state.choice = [_filterOptions[0]];
                          break;
                        case 'incomplete':
                          state.choice = [_filterOptions[1]];
                          break;
                      }
                    }
                  } else {
                    // Update the filter option in the provider.
                    switch (state.choice!.first.title) {
                      case 'complete':
                        bookProvider.updateFilterOption(FilterOptions.complete);
                        break;
                      case 'incomplete':
                        bookProvider
                            .updateFilterOption(FilterOptions.incomplete);
                        break;
                    }
                  }
                }
              }
            },
          ),
          if (bookProvider.search.isNotEmpty) ...[
            if (bookProvider.bookSearchResults.isEmpty) ...[
              const Center(
                child: Text('No Results Found'),
              )
            ] else ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var book in bookProvider.bookSearchResults) ...[
                        BookWidget(
                          book: book,
                        ).animate().fadeIn(duration: 1000.ms).then(
                              delay: 1000.ms,
                            ),
                      ]
                    ],
                  ),
                ),
              ),
            ]
          ] else if (bookProvider.selectedFilterOption ==
              FilterOptions.complete) ...[
            Expanded(
              child: PagedListView<int, BookModel>(
                key: UniqueKey(),
                pagingController: _completePagingController,
                builderDelegate: PagedChildBuilderDelegate<BookModel>(
                  itemBuilder: (context, book, index) => BookWidget(
                    book: book,
                  ).animate().fadeIn(duration: 1000.ms).then(
                        delay: 1000.ms,
                      ),
                ),
              ),
            ),
          ] else if (bookProvider.selectedFilterOption ==
              FilterOptions.incomplete) ...[
            Expanded(
              child: PagedListView<int, BookModel>(
                key: UniqueKey(),
                pagingController: _incompletePagingController,
                builderDelegate: PagedChildBuilderDelegate<BookModel>(
                  itemBuilder: (context, book, index) => BookWidget(
                    book: book,
                  ).animate().fadeIn(duration: 1000.ms).then(
                        delay: 1000.ms,
                      ),
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: PagedListView<int, BookModel>(
                key: UniqueKey(),
                pagingController: _defaultPagingController,
                builderDelegate: PagedChildBuilderDelegate<BookModel>(
                  itemBuilder: (context, book, index) => BookWidget(
                    book: book,
                  ).animate().fadeIn(duration: 1000.ms).then(
                        delay: 1000.ms,
                      ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Future<void> _defaultFetchPage(int pageKey) async {
    try {
      final List<BookModel> books = await _bookService.fetchPage(
        uid: _getStorage.read('uid'),
        title: _lastTitle,
        limit: Globals.bookPageFetchLimit,
      );

      final bool isLastPage = books.length < Globals.bookPageFetchLimit;

      isLastPage
          ? _defaultPagingController.appendLastPage(books)
          : _defaultPagingController.appendPage(books, 0);

      // Update the last date to pick up from in pagination.
      if (books.isNotEmpty) {
        _lastTitle = books[books.length - 1].title;
      }
    } catch (error) {
      _defaultPagingController.error = error;
    }
  }

  Future<void> _completeFetchPage(int pageKey) async {
    try {
      final List<BookModel> books = await _bookService.fetchPage(
        uid: _getStorage.read('uid'),
        title: _lastTitle,
        limit: Globals.bookPageFetchLimit,
        complete: true,
      );

      final bool isLastPage = books.length < Globals.bookPageFetchLimit;

      isLastPage
          ? _completePagingController.appendLastPage(books)
          : _completePagingController.appendPage(books, 0);

      // Update the last date to pick up from in pagination.
      if (books.isNotEmpty) {
        _lastTitle = books[books.length - 1].title;
      }
    } catch (error) {
      _completePagingController.error = error;
    }
  }

  Future<void> _incompleteFetchPage(int pageKey) async {
    try {
      final List<BookModel> books = await _bookService.fetchPage(
        uid: _getStorage.read('uid'),
        title: _lastTitle,
        limit: Globals.bookPageFetchLimit,
        complete: false,
      );

      final bool isLastPage = books.length < Globals.bookPageFetchLimit;

      isLastPage
          ? _incompletePagingController.appendLastPage(books)
          : _incompletePagingController.appendPage(books, 0);

      // Update the last date to pick up from in pagination.
      if (books.isNotEmpty) {
        _lastTitle = books[books.length - 1].title;
      }
    } catch (error) {
      _incompletePagingController.error = error;
    }
  }
}
