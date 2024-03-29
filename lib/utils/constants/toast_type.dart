import 'package:flutter/material.dart';

enum ToastType {
  success(Colors.blue, Icon(Icons.check)),
  failure(Colors.red, Icon(Icons.cancel));

  const ToastType(
    this.color,
    this.icon,
  );

  final MaterialColor color;
  final Icon icon;
}
