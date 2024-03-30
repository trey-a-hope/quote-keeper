import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:quote_keeper/data/services/share_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/config/size_config.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareService = ShareService();

    final book = ref.watch(
      Providers.dashboardQuoteProvider,
    );

    // Prompt user for potential updated version of app.
    NewVersionPlus(
      iOSId: 'com.example.book-quotes',
      androidId: 'com.io.book_quotes',
      androidPlayStoreCountry: "es_ES",
      androidHtmlReleaseNotes: true,
    ).showAlertIfNecessary(context: context);

    SizeConfig.init(context);

    return book.when(
      data: (data) => data != null
          ? SafeArea(
              child: Stack(
                children: [
                  Image.network(
                    data.imgPath ?? Globals.networkImages.libraryBackground,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    opacity: const AlwaysStoppedAnimation(.05),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'A Wise Person Once Said...',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const Gap(32),
                        Text(
                          '"${data.quote}"',
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Lottie.asset(
                              Globals.lottie.quotes,
                              height: 100,
                            ),
                            const Gap(8),
                            SizedBox(
                              height: 130,
                              width: 85,
                              child: CachedNetworkImage(
                                imageUrl: data.imgPath != null
                                    ? data.imgPath!
                                    : Globals.networkImages.libraryBackground,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const Gap(8),
                            Lottie.asset(
                              Globals.lottie.quotes,
                              height: 100,
                            ),
                          ],
                        ),
                        const Gap(16),
                        Text(
                          '~ ${data.author}, ${data.title}',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const Gap(32),
                        ElevatedButton.icon(
                          onPressed: () => shareService.share(
                            text: '"${data.quote}"',
                            subject:
                                'Here\'s my quote of the day from ${data.title} by ${data.author}',
                          ),
                          icon: const Icon(
                            Icons.ios_share,
                          ),
                          label: const Text('Share'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : Stack(
              children: [
                Image.network(
                  Globals.networkImages.libraryBackground,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  opacity: const AlwaysStoppedAnimation(.1),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Book Found...',
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
      error: (err, stack) => Center(
        child: Lottie.asset(
          Globals.lottie.error,
          height: 100,
        ),
      ),
      loading: () => Center(
        child: Lottie.asset(
          Globals.lottie.books,
          height: 100,
        ),
      ),
    );
  }
}
