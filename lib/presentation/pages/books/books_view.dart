import 'package:book_quotes/presentation/pages/books/books_view_model.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:book_quotes/presentation/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class BooksView extends StatelessWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BooksViewModel>(
      init: BooksViewModel(),
      builder: (model) => SimplePageWidget(
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Reload'),
          icon: const Icon(Icons.refresh),
          heroTag: 'refresh2',
          backgroundColor: Colors.green,
          onPressed: () => model.load(),
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
        title: 'Books - ${model.totalBookAccount}',
        child: ListView.builder(
          itemCount: model.books.length,
          itemBuilder: (_, index) => BookWidget(
            book: model.books[index],
          ).animate().fadeIn(duration: 1000.ms).then(delay: 1000.ms),
        ),
      ),
    );
  }
}
