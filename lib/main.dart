import 'dart:async';

import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quote_keeper/utils/config/initial_bindings.dart';
import 'package:quote_keeper/utils/config/app_routes.dart';
import 'package:quote_keeper/utils/config/app_themes.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await GetStorage.init();

    Get.lazyPut(() => GetStorage(), fenix: true);

    // Set app version and build number.
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Globals.version = packageInfo.version;
    Globals.buildNumber = packageInfo.buildNumber;

    // Set light/dark mode theme.
    final GetStorage getStorage = Get.find();
    Get.changeThemeMode(getStorage.read(Globals.darkModeEnabled) ?? false
        ? ThemeMode.dark
        : ThemeMode.light);

    runApp(
      ProviderScope(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          title: 'QuoteKeeper',
          initialBinding: InitialBinding(),
          initialRoute: Globals.routeSplash,
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
