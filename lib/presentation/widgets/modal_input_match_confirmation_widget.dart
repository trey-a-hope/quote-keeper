import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InputMatchConfirmationWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final String match;

  const InputMatchConfirmationWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.match,
  });

  @override
  State<InputMatchConfirmationWidget> createState() =>
      _InputMatchConfirmationWidget();
}

class _InputMatchConfirmationWidget
    extends State<InputMatchConfirmationWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(
      () => setState(
        () => _isButtonEnabled = _textEditingController.text == widget.match,
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Platform.isIOS
      ? CupertinoAlertDialog(
          title: Text(widget.title),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: widget.hintText),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: false,
              child: const Text('NO'),
              onPressed: () => context.pop(false),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => _isButtonEnabled ? context.pop(true) : null,
              child: const Text('YES'),
            ),
          ],
        )
      : AlertDialog(
          title: Text(widget.title),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: widget.hintText),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('NO', style: TextStyle(color: Colors.black)),
              onPressed: () => context.pop(false),
            ),
            ElevatedButton(
              onPressed: () => _isButtonEnabled ? context.pop(true) : null,
              child: const Text(
                'YES',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
}
