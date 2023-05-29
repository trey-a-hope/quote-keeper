import 'package:book_quotes/app/initial_bindings.dart';
import 'package:book_quotes/config/app_routes.dart';
import 'package:book_quotes/config/app_themes.dart';

import 'package:book_quotes/utils/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookQuotesApp extends StatelessWidget {
  BookQuotesApp({super.key});

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
      initialRoute: Globals.routeSplash,
      getPages: AppRoutes.routes,
    );
  }
}
