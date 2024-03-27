import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/dashboard/quotes_all_time_count_widget.dart';
import 'package:quote_keeper/presentation/widgets/dashboard/quotes_this_month_count_widget.dart';
import 'package:quote_keeper/presentation/widgets/dashboard/quotes_this_week_count_widget.dart';
import 'package:quote_keeper/presentation/widgets/dashboard/quotes_this_year_count_widget.dart';
import 'package:quote_keeper/presentation/widgets/profile/profile_stats_widget.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarWidget.appBar(
          title: 'Profile',
          implyLeading: false,
          context: context,
          actions: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                  IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () => context.goNamed(Globals.routes.editProfile),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileStatsWidget(),
                Text(
                  'Quote Stats',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(32),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    QuotesThisWeekCountWidget(),
                    QuotesThisMonthCountWidget(),
                    QuotesThisYearCountWidget(),
                    QuotesAllTimeCountWidget(),
                  ],
                ),
                const Gap(16),
                const Divider(),
                const Gap(16),
                Lottie.asset(
                  Globals.lottie.books,
                ),
              ],
            ),
          ),
        ),
      );
}
