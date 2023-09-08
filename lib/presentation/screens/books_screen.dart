import 'package:book_quotes/domain/providers/book_provider.dart';
import 'package:book_quotes/domain/providers/providers.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:book_quotes/presentation/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class BooksScreen extends ConsumerWidget {
  const BooksScreen({Key? key}) : super(key: key);

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
      child: ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: (_, index) => BookWidget(
          book: bookProvider.books[index],
          showBook: (_) => bookProvider.showBook(
            book: bookProvider.books[index],
          ),
          hideBook: (_) => bookProvider.hideBook(
            book: bookProvider.books[index],
          ),
        ).animate().fadeIn(duration: 1000.ms).then(delay: 1000.ms),
      ),
    );
  }
}
