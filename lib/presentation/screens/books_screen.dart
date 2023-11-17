import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/providers/book_provider.dart';
import 'package:quote_keeper/domain/providers/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:quote_keeper/presentation/widgets/book_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class BooksScreen extends ConsumerWidget {
  final PagingController<int, BookModel> _pagingController =
      PagingController(firstPageKey: 0);

  BooksScreen({Key? key}) : super(key: key) {
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Timestamp? _lastDate;

  final BookService _bookService = Get.find();
  final ModalService _modalService = Get.find();
  final GetStorage _getStorage = Get.find();

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
            bookProvider.search.isNotEmpty
                ? bookProvider.bookSearchResults.isEmpty
                    ? const Center(
                        child: Text('No Results Found'),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var book
                                  in bookProvider.bookSearchResults) ...[
                                BookWidget(
                                        onTap: () {
                                          Navigator.of(context).pop(book);
                                        },
                                        book: book,
                                        showBook: (_) => bookProvider.showBook(
                                              book: book,
                                              books:
                                                  _pagingController.itemList!,
                                            ),
                                        hideBook: (_) => bookProvider.hideBook(
                                              book: book,
                                              books:
                                                  _pagingController.itemList!,
                                            ),
                                        shareBook: (_) =>
                                            bookProvider.shareBook(
                                              book: book,
                                            ),
                                        deleteBook: (_) async {
                                          bool? confirm = await _modalService
                                              .showConfirmation(
                                            context: context,
                                            title: 'Delete ${book.title}',
                                            message: 'Are you sure?',
                                          );

                                          if (confirm == null ||
                                              confirm == false) {
                                            return;
                                          }

                                          bookProvider.deleteBook(
                                            book: book,
                                          );
                                        })
                                    .animate()
                                    .fadeIn(duration: 1000.ms)
                                    .then(
                                      delay: 1000.ms,
                                    ),
                              ]
                            ],
                          ),
                        ),
                      )
                : Expanded(
                    child: PagedListView<int, BookModel>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<BookModel>(
                        itemBuilder: (context, book, index) => BookWidget(
                                onTap: () {
                                  Navigator.of(context).pop(book);
                                },
                                book: book,
                                showBook: (_) => bookProvider.showBook(
                                      book: book,
                                      books: _pagingController.itemList!,
                                    ),
                                hideBook: (_) => bookProvider.hideBook(
                                      book: book,
                                      books: _pagingController.itemList!,
                                    ),
                                shareBook: (_) => bookProvider.shareBook(
                                      book: book,
                                    ),
                                deleteBook: (_) async {
                                  bool? confirm =
                                      await _modalService.showConfirmation(
                                    context: context,
                                    title: 'Delete ${book.title}',
                                    message: 'Are you sure?',
                                  );

                                  if (confirm == null || confirm == false) {
                                    return;
                                  }

                                  bookProvider.deleteBook(
                                    book: book,
                                  );
                                }).animate().fadeIn(duration: 1000.ms).then(
                              delay: 1000.ms,
                            ),
                      ),
                    ),
                  ),
          ],
        ));
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<BookModel> books = await _bookService.fetchPage(
        uid: _getStorage.read('uid'),
        created: _lastDate,
        limit: Globals.bookPageFetchLimit,
      );

      final bool isLastPage = books.length < Globals.bookPageFetchLimit;

      isLastPage
          ? _pagingController.appendLastPage(books)
          : _pagingController.appendPage(books, 0);

      // Update the last date to pick up from in pagination.
      if (books.isNotEmpty) {
        _lastDate = books[books.length - 1].created;
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
