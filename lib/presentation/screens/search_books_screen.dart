import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchBooksScreen extends ConsumerWidget {
  SearchBooksScreen({Key? key}) : super(key: key);

  /// Editing controller for message on critique.
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(Providers.searchBooksAsyncNotifierProvider);

    final searchBooksAsyncNotifier =
        ref.read(Providers.searchBooksAsyncNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'Choose Book To Quote',
        implyLeading: true,
        context: context,
      ),
      body: Column(
        children: [
          TextField(
            style: Theme.of(context).textTheme.headlineSmall!,
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
          results.when(
            data: (data) => Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final searchBooksResult = data[index];

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
