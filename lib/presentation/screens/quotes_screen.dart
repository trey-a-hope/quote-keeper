import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/domain/models/action_sheet_option.dart';
import 'package:quote_keeper/domain/notifiers/book_search_term_notifier.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/quote_card_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      ref.read(Providers.booksAsyncProvider.notifier).getNextBooks();
    }
  }

  IconData _getIconFromSearchDescending() =>
      ref.watch(Providers.bookSearchIsDescendingProvider)
          ? Icons.arrow_downward
          : Icons.arrow_upward;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'Quotes',
        implyLeading: false,
        context: context,
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.goNamed(Globals.routes.searchBooks),
        ),
        actions: [
          IconButton(
            onPressed: () => ModalService.showAlert(
              context: context,
              title: 'Info',
              message: 'Hold down a quote to open it.',
            ),
            icon: const Icon(Icons.info),
          ),
          IconButton(
            icon: Icon(_getIconFromSearchDescending()),
            onPressed: () => ref
                .read(Providers.bookSearchIsDescendingProvider.notifier)
                .toggle(),
          ),
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () async {
              final result = await ModalService.showActionSheet<BookSearchTerm>(
                context: context,
                title: 'Sort By',
                options: [
                  for (int i = 0; i < BookSearchTerm.values.length; i++) ...[
                    ActionSheetOption(
                      label: BookSearchTerm.values[i].label,
                      value: BookSearchTerm.values[i],
                      selected: ref.read(Providers.bookSearchTermProvider) ==
                          BookSearchTerm.values[i],
                    ),
                  ],
                ],
              );

              if (result == null) return;

              ref
                  .read(Providers.bookSearchTermProvider.notifier)
                  .updateTerm(result);
            },
          ),
        ],
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
                    .read(Providers.searchQuotesAsyncProvider.notifier)
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
                final booksAsyncValue = ref.watch(Providers.booksAsyncProvider);
                final searchQuotesValue =
                    ref.watch(Providers.searchQuotesAsyncProvider);

                if (_search.isNotEmpty && searchQuotesValue.hasValue) {
                  final results = searchQuotesValue.value!;

                  return results.isEmpty
                      ? const Center(
                          child: Text('No Results Found'),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: results.length,
                          itemBuilder: (c, index) {
                            final book = results[index];
                            return QuoteCardWidget(
                              book: book,
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
                    itemBuilder: (c, index) {
                      final book = books[index];
                      return QuoteCardWidget(
                        book: book,
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
