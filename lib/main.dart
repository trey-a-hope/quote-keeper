import 'dart:async';

import 'package:book_quotes/app/book_quotes_app.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await GetStorage.init();

    Get.lazyPut(() => GetStorage(), fenix: true);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Globals.version = packageInfo.version;
    Globals.buildNumber = packageInfo.buildNumber;

    runApp(BookQuotesApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
