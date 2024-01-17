import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/widgets/quote_card_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class MostRecentQuoteWidget extends ConsumerWidget {
  const MostRecentQuoteWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mostRecentQuoteAsync =
        ref.watch(Providers.mostRecentQuoteAsyncNotifierProvider);

    return mostRecentQuoteAsync.when(
      data: (data) =>
          data == null ? const Text('Null') : QuoteCardWidget(book: data),
      error: (err, stack) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
