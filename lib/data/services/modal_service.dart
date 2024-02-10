import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/widgets/modal_alert_widget.dart';
import 'package:quote_keeper/presentation/widgets/modal_confirmation_widget.dart';
import 'package:quote_keeper/presentation/widgets/modal_input_match_confirmation_widget.dart';

class ModalService {
  void showInSnackBar({
    required BuildContext context,
    required Icon icon,
    required String message,
    required String title,
  }) {
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      content: ListTile(
        leading: icon,
        title: Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white,
              ),
        ),
        subtitle: Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showAlert({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext buildContext) => AlertWidget(
        title: title,
        message: message,
      ),
    );
  }

  Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
  }) async =>
      await showDialog<bool>(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ConfirmationWidget(
          title: title,
          message: message,
        ),
      );

  Future<bool?> showInputMatchConfirmation({
    required BuildContext context,
    required String title,
    required String hintText,
    required String match,
  }) =>
      showDialog<bool>(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Material(
          color: Colors.transparent,
          child: InputMatchConfirmationWidget(
            hintText: hintText,
            title: title,
            match: match,
          ),
        ),
      );
}
