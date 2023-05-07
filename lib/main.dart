import 'package:book_quotes/app/book_quotes_app.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await GetStorage.init();

  Get.lazyPut(() => GetStorage(), fenix: true);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Globals.version = packageInfo.version;
  Globals.buildNumber = packageInfo.buildNumber;

  runApp(BookQuotesApp());
}
