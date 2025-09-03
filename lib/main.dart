import 'dart:async';

import 'package:feedback/feedback.dart';
import 'package:quote_keeper/firebase_options.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quote_keeper/utils/config/app_themes.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // await _setupCrashlytics();

    // Set app version and build number.
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Globals.version = packageInfo.version;
    Globals.buildNumber = packageInfo.buildNumber;

    runApp(
      const ProviderScope(
        child: BetterFeedback(
          child: QuoteKeeperApp(),
        ),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class QuoteKeeperApp extends ConsumerWidget {
  const QuoteKeeperApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(Providers.routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.dark,
      title: 'Quote Keeper',
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

// Future<void> _setupCrashlytics() async {
//   final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

//   await crashlytics.setCrashlyticsCollectionEnabled(true);

//   FlutterError.onError = (errorDetails) async {
//     await crashlytics.recordFlutterFatalError(errorDetails);
//     await crashlytics.recordFlutterError(errorDetails);
//   };

//   // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
//   PlatformDispatcher.instance.onError = (error, stack) {
//     crashlytics.recordError(error, stack, fatal: true);
//     return true;
//   };
// }
