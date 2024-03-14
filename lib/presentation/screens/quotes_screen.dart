import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/quote_card_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:quote_keeper/utils/constants/globals.dart';

class QuotesScreen extends ConsumerStatefulWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends ConsumerState<QuotesScreen> {
  var _search = '';

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
    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'Quotes',
        implyLeading: false,
        context: context,
        action: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.goNamed(Globals.routes.searchBooks),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: AnimatedSearchBar(
              label: Globals.labels.enterBookTitle,
              onChanged: (value) {
                _search = value;
                ref
                    .read(Providers.searchQuotesAsyncNotifierProvider.notifier)
                    .onSearchTextChanges(value);
              },
              textInputAction: TextInputAction.done,
              searchStyle: Theme.of(context).textTheme.headlineSmall!,
              labelStyle: Theme.of(context).textTheme.headlineSmall!,
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final booksAsyncValue =
                    ref.watch(Providers.booksAsyncNotifierProvider);
                final searchQuotesValue =
                    ref.watch(Providers.searchQuotesAsyncNotifierProvider);
                if (_search.isNotEmpty && searchQuotesValue.hasValue) {
                  final results = searchQuotesValue.value!;

                  return results.isEmpty
                      ? const Center(
                          child: Text('No Results Found'),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final book = results[index];
                            return QuoteCardWidget(
                              book: book,
                              onTap: () => context.goNamed(
                                Globals.routes.editQuote,
                                pathParameters: <String, String>{
                                  // Note: Conversion between String and Timestamp since Timestamp can't be encodded.
                                  'book': jsonEncode(
                                    {
                                      'id': book.id,
                                      'title': book.title,
                                      'author': book.author,
                                      'quote': book.quote,
                                      'imgPath': book.imgPath,
                                      'hidden': book.hidden,
                                      'complete': book.complete,
                                      'created': book.created.toIso8601String(),
                                      'modified':
                                          book.modified.toIso8601String(),
                                      'uid': book.uid,
                                    },
                                  )
                                },
                              ),
                            ).animate().fadeIn(duration: 1000.ms).then(
                                  delay: 1000.ms,
                                );
                          },
                        );
                } else if (booksAsyncValue.hasError) {
                  return Center(
                    child: Text(
                      booksAsyncValue.error.toString(),
                    ),
                  );
                } else if (booksAsyncValue.hasValue) {
                  var books = booksAsyncValue.value!;

                  if (books.isEmpty) {
                    return const Center(
                      child: Text(
                        'You don\'t have any quotes.\nAdd one now!',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return QuoteCardWidget(
                        book: book,
                        onTap: () => context.goNamed(
                          Globals.routes.editQuote,
                          pathParameters: <String, String>{
                            // Note: Conversion between String and Timestamp since Timestamp can't be encodded.
                            'book': jsonEncode(
                              {
                                'id': book.id,
                                'title': book.title,
                                'author': book.author,
                                'quote': book.quote,
                                'imgPath': book.imgPath,
                                'hidden': book.hidden,
                                'complete': book.complete,
                                'created': book.created.toIso8601String(),
                                'modified': book.modified.toIso8601String(),
                                'uid': book.uid,
                              },
                            )
                          },
                        ),
                      ).animate().fadeIn(duration: 1000.ms).then(
                            delay: 1000.ms,
                          );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
