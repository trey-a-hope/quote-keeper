import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quote_keeper/utils/config/app_routes.dart';
import 'package:quote_keeper/utils/config/app_themes.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    await _setupCrashlytics();

    await GetStorage.init();

    Get.lazyPut(() => GetStorage(), fenix: true);

    // Set app version and build number.
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Globals.version = packageInfo.version;
    Globals.buildNumber = packageInfo.buildNumber;

    final getStorage = GetStorage();

    // Set light/dark mode theme.
    Get.changeThemeMode(getStorage.read(Globals.darkModeEnabled) ?? false
        ? ThemeMode.dark
        : ThemeMode.light);

    runApp(
      ProviderScope(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          title: 'Quote Keeper',
          routerConfig: router,
        ),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

Future<void> _setupCrashlytics() async {
  final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  await crashlytics.setCrashlyticsCollectionEnabled(true);

  FlutterError.onError = (errorDetails) async {
    await crashlytics.recordFlutterFatalError(errorDetails);
    await crashlytics.recordFlutterError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    crashlytics.recordError(error, stack, fatal: true);
    return true;
  };
}
