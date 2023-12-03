import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_keeper/presentation/widgets/modal/alert_widget.dart';
import 'package:quote_keeper/presentation/widgets/modal/confirmation_widget.dart';
import 'package:quote_keeper/presentation/widgets/modal/input_match_confirmation_widget.dart';

class ModalService extends GetxService {
  void showInSnackBar({
    required BuildContext context,
    required String message,
    required String title,
  }) {
    Get.snackbar(
      title, // Title of the Snackbar
      message, // Message of the Snackbar
      snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
      backgroundColor: Theme.of(context).primaryColor,
      colorText: Colors.white,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2), // Duration of the Snackbar display
      // You can add more customization as needed
    );
  }

  void showAlert({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
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
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => InputMatchConfirmationWidget(
          hintText: hintText,
          title: title,
          match: match,
        ),
      );
}
