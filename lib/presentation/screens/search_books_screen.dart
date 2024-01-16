import 'dart:convert';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchBooksScreen extends ConsumerWidget {
  const SearchBooksScreen({Key? key}) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: AnimatedSearchBar(
              label: Globals.searchLabel,
              onChanged: searchBooksAsyncNotifier.onSearchTextChanged,
              textInputAction: TextInputAction.done,
              searchStyle: Theme.of(context).textTheme.headlineSmall!,
              labelStyle: Theme.of(context).textTheme.headlineSmall!,
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
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
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
