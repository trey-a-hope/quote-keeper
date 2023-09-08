import 'package:flutter/material.dart';

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
