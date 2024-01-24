import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/widgets/profile/profile_stat_badget_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class QuotesThisMonthCountWidget extends ConsumerWidget {
  const QuotesThisMonthCountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countValue =
        ref.watch(Providers.quotesThisMonthCountStateNotifierProvider);

    return countValue.when(
      data: (data) => ProfileStatBadgetWidget(
        count: data,
        label: 'Monthly',
        color: Colors.cyan,
      ),
      error: (err, stack) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
