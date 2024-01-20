import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/widgets/profile/profile_stat_badget_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class QuotesThisWeekCountWidget extends ConsumerWidget {
  const QuotesThisWeekCountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var quotesThisWeekCount =
        ref.watch(Providers.quotesThisWeekCountStateNotifierProvider);

    return quotesThisWeekCount.when(
      data: (data) => ProfileStatBadgetWidget(
        count: data,
        label: 'Weekly',
        color: Colors.green,
      ),
      error: (err, stack) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
