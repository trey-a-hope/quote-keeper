import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/data/services/tutorial_service.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/presentation/widgets/qk_scaffold_widget.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBooksScreen extends ConsumerWidget {
  SearchBooksScreen({Key? key}) : super(key: key);

  /// Editing controller for message on critique.
  final _textController = TextEditingController();

  /// Key for the scaffold.
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _tutorialService = TutorialService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShowTutorial =
        ref.read(Providers.shouldDisplayTutorialStateNotifierProvider);

    final searchBooksAsyncNotifierProvider =
        ref.watch(Providers.searchBooksAsyncNotifierProvider);

    final searchBooksAsyncNotifier =
        ref.read(Providers.searchBooksAsyncNotifierProvider.notifier);

    if (shouldShowTutorial) {
      _tutorialService.showSearchBookTutorial(context);
    }

    return QKScaffoldWidget(
      scaffoldKey: _scaffoldKey,
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => context.pop(),
      ),
      title: 'Search Books',
      child: Column(
        children: [
          TextField(
            key: _tutorialService.searchBookTarget,
            style: context.textTheme.headlineSmall!,
            controller: _textController,
            autocorrect: false,
            onChanged: (text) {
              searchBooksAsyncNotifier.udpateSearchText(text: text);
            },
            cursorColor: Theme.of(context).textTheme.headlineSmall!.color,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
              ),
              suffixIcon: GestureDetector(
                child: Icon(
                  Icons.clear,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {
                  _textController.clear();
                  searchBooksAsyncNotifier.udpateSearchText(text: '');
                },
              ),
              border: InputBorder.none,
              hintText: 'Enter title here...',
              hintStyle: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          searchBooksAsyncNotifierProvider.when(
            data: (results) => Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (BuildContext context, int index) {
                  final SearchBooksResultModel searchBooksResult =
                      results[index];

                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: '${searchBooksResult.imgUrl}',
                      imageBuilder: (context, imageProvider) => Image(
                        image: imageProvider,
                        height: 100,
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(
                      searchBooksResult.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      searchBooksResult.author ?? 'Unknown',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onTap: () => context.goNamed(
                      Globals.routeCreateQuote,
                      pathParameters: <String, String>{
                        'searchBooksResult': jsonEncode(
                          searchBooksResult,
                        ),
                      },
                    ),
                  );
                },
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
