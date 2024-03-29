import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/domain/models/action_sheet_option.dart';
import 'package:quote_keeper/presentation/widgets/modal_alert_widget.dart';
import 'package:quote_keeper/presentation/widgets/modal_confirmation_widget.dart';
import 'package:quote_keeper/presentation/widgets/modal_input_match_confirmation_widget.dart';
import 'package:quote_keeper/utils/constants/toast_type.dart';
import 'package:toastification/toastification.dart';

class ModalService {
  /// Displays a toast message.
  /// Takes in a required context and message.
  /// The toastType modifies ui icons and colors.
  /// The alignment determines position on screen.
  static void showToast({
    required BuildContext context,
    required String message,
    ToastType toastType = ToastType.success,
    Alignment alignment = Alignment.bottomCenter,
  }) =>
      toastification.show(
        context: context,
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text(message),
        alignment: alignment,
        animationDuration: const Duration(milliseconds: 300),
        icon: toastType.icon,
        primaryColor: toastType.color,
        backgroundColor: toastType.color.shade50,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: BorderRadius.circular(12),
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.onHover,
        closeOnClick: true,
      );

  static void showAlert({
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

  static Future<bool?> showConfirmation({
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

  static Future<bool?> showInputMatchConfirmation({
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

  /// Takes in a list of ActionSheetOption of type <T>.
  /// Each ActionSheetOption contains info about the option.
  /// Returns the selected "T" value.
  /// Provides an optional title and message.
  static Future<T?> showActionSheet<T>({
    required BuildContext context,
    required List<ActionSheetOption<T>> options,
    String? title,
    String? message,
    bool showCancelButton = false,
  }) async =>
      await showCupertinoModalPopup<T>(
        context: context,
        builder: (c) => CupertinoActionSheet(
          title: title != null
              ? Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              : null,
          message: message != null
              ? Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              : null,
          cancelButton: showCancelButton
              ? CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                )
              : null,
          actions: <CupertinoActionSheetAction>[
            for (int i = 0; i < options.length; i++) ...[
              CupertinoActionSheetAction(
                // Return the value of the ActionSheetOption.
                onPressed: () => Navigator.of(c).pop(
                  options[i].value,
                ),
                isDestructiveAction: options[i].isDestructive,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        options[i].label,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    // Display arrow to show there are nested options.
                    if (options[i].hasMore) ...[
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.chevron_right,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ],
        ),
      );
}
