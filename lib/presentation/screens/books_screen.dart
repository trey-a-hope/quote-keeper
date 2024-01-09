import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/presentation/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/presentation/widgets/quoter_keeper_scaffold.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BooksScreen> createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksScreen> {
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
      ref.read(Providers.booksAsyncNotifierProvider.notifier).getNextBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalBookCount =
        ref.watch(Providers.totalBooksCountStateNotifierProvider);

    return QuoteKeeperScaffold(
      title: '$totalBookCount Books',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      child: Consumer(
        builder: (context, ref, _) {
          final booksAsyncValue =
              ref.watch(Providers.booksAsyncNotifierProvider);

          if (booksAsyncValue.hasError) {
            return Center(
              child: Text(
                booksAsyncValue.error.toString(),
              ),
            );
          } else if (booksAsyncValue.hasValue) {
            var books = booksAsyncValue.value!;
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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
