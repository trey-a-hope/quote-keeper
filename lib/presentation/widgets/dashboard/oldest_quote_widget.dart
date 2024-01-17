import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/widgets/quote_card_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class OldestQuoteWidget extends ConsumerWidget {
  const OldestQuoteWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var oldestQuoteAsync =
        ref.watch(Providers.oldestQuoteAsyncNotifierProvider);

    return oldestQuoteAsync.when(
      data: (data) =>
          data == null ? const Text('Null') : QuoteCardWidget(book: data),
      error: (err, stack) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
