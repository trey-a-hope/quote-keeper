import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/widgets/profile/profile_stat_badget_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class QuotesAllTimeCountWidget extends ConsumerWidget {
  const QuotesAllTimeCountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countValue =
        ref.watch(Providers.quotesAllTimeCountAsyncNotifierProvider);

    return countValue.when(
      data: (count) => ProfileStatBadgetWidget(
        count: count,
        label: 'All',
        color: Colors.deepOrangeAccent,
      ),
      error: (err, stack) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
