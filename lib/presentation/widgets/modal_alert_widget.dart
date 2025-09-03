import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_platform/universal_platform.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String message;

  const AlertWidget({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) =>
      UniversalPlatform.isIOS || UniversalPlatform.isMacOS
          ? CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('OK'),
                  onPressed: () {
                    context.pop();
                  },
                )
              ],
            )
          : AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            );
}
