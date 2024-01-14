import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/data/services/share_service.dart';
import 'package:quote_keeper/data/services/tutorial_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DashboardScreen extends ConsumerWidget {
  DashboardScreen({Key? key}) : super(key: key);

  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  final _shareService = ShareService();
  // final _tutorialService = TutorialService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bookAsyncValue =
        ref.watch(Providers.dashboardBookAsyncNotifierProvider);

    var shouldDisplayTutorial =
        !ref.read(Providers.tutorialCompleteStateNotifierProvider);

    // Prompt user for potential updated version of app.
    Globals.newVersionPlus.showAlertIfNecessary(context: context);

    return bookAsyncValue.when(
      data: (book) => Builder(
        builder: (context) {
          // if (shouldDisplayTutorial) {
          //   _tutorialService.showDashboardTutorial(context);
          // }

          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: book?.imgPath != null
                        ? Image.network(book!.imgPath!).image
                        : Image.network(Globals.libraryBackground).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.8)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    book?.quote != null
                        ? '"${book!.quote}"'
                        : 'No quotes yet...',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                  ),
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (book != null) ...[
                          FloatingActionButton.extended(
                            icon: const Icon(Icons.refresh),
                            backgroundColor: Theme.of(context)
                                .floatingActionButtonTheme
                                .backgroundColor,
                            onPressed: () => ref
                                .read(Providers
                                    .dashboardBookAsyncNotifierProvider
                                    .notifier)
                                .getRandomBook(),
                            label: Text(
                              'Get Random Quote',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .foregroundColor,
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        SpeedDial(
                          // key: _tutorialService.dashboardTarget,
                          animatedIcon: AnimatedIcons.menu_close,
                          animatedIconTheme: const IconThemeData(size: 28.0),
                          backgroundColor: Theme.of(context)
                              .floatingActionButtonTheme
                              .backgroundColor,
                          foregroundColor: Theme.of(context)
                              .floatingActionButtonTheme
                              .foregroundColor,
                          visible: true,
                          curve: Curves.bounceInOut,
                          children: [
                            SpeedDialChild(
                              child: const Icon(Icons.settings,
                                  color: Colors.white),
                              backgroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                              foregroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .foregroundColor,
                              onTap: () => context.goNamed(
                                Globals.routeSettings,
                              ),
                              label: 'Settings',
                              labelStyle: labelStyle,
                              labelBackgroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                            ),
                            if (book != null) ...[
                              SpeedDialChild(
                                child:
                                    const Icon(Icons.book, color: Colors.white),
                                backgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                                foregroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .foregroundColor,
                                onTap: () => context.goNamed('books'),
                                label: 'View All Quotes',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                              ),
                            ],
                            if (book == null) ...[
                              SpeedDialChild(
                                child: const Icon(Icons.refresh,
                                    color: Colors.white),
                                backgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                                foregroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .foregroundColor,
                                onTap: () => ref
                                    .read(Providers
                                        .dashboardBookAsyncNotifierProvider
                                        .notifier)
                                    .getRandomBook(),
                                label: 'Refresh',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                              ),
                            ],
                            SpeedDialChild(
                              child: const Icon(Icons.add, color: Colors.white),
                              backgroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                              foregroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .foregroundColor,
                              onTap: () =>
                                  context.goNamed(Globals.routeSearchBooks),
                              label: 'Add New Quote',
                              labelStyle: labelStyle,
                              labelBackgroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                            ),
                            if (book != null) ...[
                              SpeedDialChild(
                                child: const Icon(Icons.share,
                                    color: Colors.white),
                                backgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                                foregroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .foregroundColor,
                                onTap: () => _shareService.share(book: book),
                                label: 'Share This Quote',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
