import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/providers/books_state_notifier_provider.dart';
import 'package:quote_keeper/domain/providers/total_books_count_state_notifier_provider.dart';
import 'package:quote_keeper/presentation/widgets/book/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:quote_keeper/presentation/widgets/quoter_keeper_scaffold.dart';

class BooksPage extends ConsumerStatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(booksStateNotifierProvider.notifier).getNextBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalBookCount = ref.watch(totalBooksCountStateNotifierProvider);

    return QuoteKeeperScaffold(
      title: '$totalBookCount Books',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Get.back(result: false);
        },
      ),
      child: FutureBuilder(
        future: ref.read(booksStateNotifierProvider.notifier).getInitialBooks(),
        builder: (context, AsyncSnapshot<List<BookModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Consumer(
            builder: (context, ref, _) {
              final books = ref.watch(booksStateNotifierProvider);
              return ListView.builder(
                controller: _scrollController,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return BookWidget(
                    book: book,
                  ).animate().fadeIn(duration: 1000.ms).then(
                        delay: 1000.ms,
                      );
                },
              );
            },
          );
        },
      ),
    );
  }
}
