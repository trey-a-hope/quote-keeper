import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:quote_keeper/data/services/share_service.dart';
import 'package:quote_keeper/presentation/widgets/profile/total_quotes_count_widget.dart';
import 'package:quote_keeper/presentation/widgets/quote_card_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/config/size_config.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends ConsumerWidget {
  DashboardScreen({Key? key}) : super(key: key);

  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  final _shareService = ShareService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Prompt user for potential updated version of app.
    Globals.newVersionPlus.showAlertIfNecessary(context: context);

    SizeConfig.init(context);

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.44,
          color: Theme.of(context).primaryColor,
        ),
        ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Gap(getProportionateScreenHeight(50)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              var user = ref
                                  .watch(Providers.authAsyncNotifierProvider);

                              return user.when(
                                data: (data) {
                                  return Text(
                                    'Welcome back\n${data!.email}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 16,
                                    ),
                                  );
                                },
                                error: (Object error, StackTrace stackTrace) =>
                                    Text(
                                  error.toString(),
                                ),
                                loading: () =>
                                    const CircularProgressIndicator(),
                              );
                            },
                          ),
                          const Gap(3),
                          const Text('Quote of The Day',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      InkWell(
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final book = ref.watch(
                                  Providers.dashboardBookAsyncNotifierProvider);
                              return book.when(
                                data: (data) => IconButton(
                                  icon: const Icon(
                                    Icons.ios_share,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _shareService.share(
                                      text: '"${data!.quote}"',
                                      subject:
                                          'Here\'s my quote of the day from ${data.title} by ${data.author}',
                                    );
                                  },
                                ),
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                                error: (error, stackTrace) => Center(
                                  child: Text(
                                    error.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(25),
                  Consumer(
                    builder: (context, ref, child) {
                      final book = ref
                          .watch(Providers.dashboardBookAsyncNotifierProvider);
                      return book.when(
                        data: (data) => QuoteCardWidget(book: data!),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => Center(
                          child: Text(
                            error.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TotalQuotesCountWidget(),
                      ],
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Most Recent Quote',
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final mostRecentQuoteAsync =
                    ref.watch(Providers.mostRecentQuoteAsyncNotifierProvider);
                return mostRecentQuoteAsync.when(
                  data: (data) => QuoteCardWidget(book: data!),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                );
              },
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Oldest Quote',
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final oldestQuoteAsync =
                    ref.watch(Providers.oldestQuoteAsyncNotifierProvider);
                return oldestQuoteAsync.when(
                  data: (data) => QuoteCardWidget(book: data!),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
