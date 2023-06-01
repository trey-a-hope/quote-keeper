import 'dart:math';

import 'package:flutter/material.dart';

extension IntExtensions on int {
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  String getRandomString() => String.fromCharCodes(
        Iterable.generate(
          this,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
}

extension StringExtensions on String {
  Color getHexColor() {
    String hexColor = this;

    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    int.parse(hexColor, radix: 16);

    int val = int.parse(hexColor, radix: 16);

    return Color(val);
  }
}
