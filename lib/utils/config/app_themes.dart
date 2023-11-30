import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  /// Fonts
  static const String fontFamily = 'Montserrat';

  /// Colors
  static const colorBlack = Colors.black;
  static const colorGrey = Color.fromRGBO(141, 141, 141, 1.0);
  static const colorWhite = Colors.white;
  static const colorDarkBlue = Color.fromRGBO(20, 25, 45, 1.0);

  /// Display Large
  static const TextStyle _displayLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 26,
    fontFamily: fontFamily,
  );

  /// Display Medium
  static const TextStyle _displayMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    fontFamily: fontFamily,
  );

  /// Display Small
  static const TextStyle _displaySmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    fontFamily: fontFamily,
  );

  /// Headline Medium
  static const TextStyle _headlineMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    fontFamily: fontFamily,
  );

  /// Headline Small
  static const TextStyle _headlineSmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    fontFamily: fontFamily,
  );

  /// Title Large
  static const TextStyle _titleLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    fontFamily: fontFamily,
  );

  /// Body Large
  static const TextStyle _bodyLarge = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.5,
    fontFamily: fontFamily,
  );

  /// Body Medium
  static const TextStyle _bodyMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.5,
    fontFamily: fontFamily,
  );

  /// Title Medium
  static const TextStyle _titleMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    fontFamily: fontFamily,
  );

  /// Title Small
  static const TextStyle _titleSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    fontFamily: fontFamily,
  );

  /// Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade900,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.orange.shade700),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.green.shade700,
    ),
    textTheme: TextTheme(
      displayLarge: _displayLarge.copyWith(color: Colors.black),
      displayMedium: _displayMedium.copyWith(color: Colors.black),
      displaySmall: _displaySmall.copyWith(color: Colors.black),
      headlineMedium: _headlineMedium.copyWith(color: Colors.black),
      headlineSmall: _headlineSmall.copyWith(color: Colors.black),
      titleLarge: _titleLarge.copyWith(color: Colors.black),
      bodyLarge: _bodyLarge.copyWith(color: Colors.grey),
      bodyMedium: _bodyMedium.copyWith(color: Colors.grey),
      titleMedium: _titleMedium.copyWith(color: Colors.black),
      titleSmall: _titleSmall.copyWith(color: Colors.grey),
    ),
  );

  /// Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Colors.grey.shade900,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade900,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.orange.shade700),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.green.shade300,
    ),
    textTheme: TextTheme(
      displayLarge: _displayLarge.copyWith(color: Colors.white),
      displayMedium: _displayMedium.copyWith(color: Colors.white),
      displaySmall: _displaySmall.copyWith(color: Colors.white),
      headlineMedium: _headlineMedium.copyWith(color: Colors.white),
      headlineSmall: _headlineSmall.copyWith(color: Colors.white),
      titleLarge: _titleLarge.copyWith(color: Colors.white),
      bodyLarge: _bodyLarge.copyWith(color: Colors.grey),
      bodyMedium: _bodyMedium.copyWith(color: Colors.grey),
      titleMedium: _titleMedium.copyWith(color: Colors.white),
      titleSmall: _titleSmall.copyWith(color: Colors.grey),
    ),
  );
}
