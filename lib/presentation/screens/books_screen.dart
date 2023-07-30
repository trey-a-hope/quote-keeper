import 'package:book_quotes/data/book_provider.dart';
import 'package:book_quotes/data/providers.dart';
import 'package:book_quotes/models/books/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:book_quotes/services/modal_service.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:book_quotes/presentation/widgets/book_widget.dart';
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
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Timestamp? _lastDate;

  final BookService _bookService = Get.find();
  final ModalService _modalService = Get.find();

  final GetStorage _getStorage = Get.find();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BookProvider bookProvider = ref.watch(Providers.bookProvider);

    return SimplePageWidget(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Reload'),
        icon: const Icon(Icons.refresh),
        heroTag: 'refresh2',
        backgroundColor: Colors.green,
        onPressed: () => bookProvider.load(),
      ),
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Get.back(result: false);
        },
      ),
      rightIconButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () async {
          Get.toNamed(Globals.routeCreateQuote);
        },
      ),
      title: 'Books - ${bookProvider.totalBookAccount}',
      child: PagedListView<int, BookModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<BookModel>(
          itemBuilder: (context, item, index) => BookWidget(
                  book: item,
                  showBook: (_) => bookProvider.showBook(
                        book: item,
                        books: _pagingController.itemList!,
                      ),
                  hideBook: (_) => bookProvider.hideBook(
                        book: item,
                        books: _pagingController.itemList!,
                      ),
                  shareBook: (_) => bookProvider.shareBook(
                        book: item,
                      ),
                  deleteBook: (_) async {
                    bool? confirm = await _modalService.showConfirmation(
                      context: context,
                      title: 'Delete Book',
                      message: 'Are you sure?',
                    );

                    if (confirm == null || confirm == false) {
                      return;
                    }

                    bookProvider.deleteBook(
                      book: item,
                    );
                  }).animate().fadeIn(duration: 1000.ms).then(
                delay: 1000.ms,
              ),
        ),
      ),
    );
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
