import 'package:book_quotes/constants/app_routes.dart';
import 'package:book_quotes/constants/app_themes.dart';
import 'package:book_quotes/constants/globals.dart';
import 'package:book_quotes/initial_binding.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetStorage _getStorage = Get.find();

  @override
  Widget build(BuildContext context) {
    Get.changeThemeMode(_getStorage.read(Globals.darkModeEnabled) ?? false
        ? ThemeMode.dark
        : ThemeMode.light);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      title: 'Book Quotes',
      initialBinding: InitialBinding(),
      initialRoute: Globals.routeDashboard,
      getPages: AppRoutes.routes,
    );
  }
}
