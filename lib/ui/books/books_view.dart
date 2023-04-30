import 'package:book_quotes/constants/globals.dart';
import 'package:book_quotes/ui/books/books_view_model.dart';
import 'package:book_quotes/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class QuotesView extends StatelessWidget {
  const QuotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BooksViewModel>(
      init: BooksViewModel(),
      builder: (model) => SimplePageWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.load(),
          child: Icon(Icons.refresh),
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
        title: 'Books',
        child: ListView.builder(
          itemCount: model.books.length,
          itemBuilder: (_, index) => BookWidget(
            book: model.books[index],
          ),
        ),
      ),
    );
  }
}
