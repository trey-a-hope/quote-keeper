import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/domain/models/action_sheet_option.dart';
import 'package:quote_keeper/presentation/widgets/modal_alert_widget.dart';

class ModalService {
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

  /// Takes in a list of ActionSheetOption of type "T"
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
        builder: (c) {
          final theme = Theme.of(context);

          return CupertinoActionSheet(
            title: title != null
                ? Text(
                    title,
                    style: theme.textTheme.bodyLarge,
                  )
                : null,
            message: message != null
                ? Text(
                    message,
                    style: theme.textTheme.bodyLarge,
                  )
                : null,
            cancelButton: showCancelButton
                ? CupertinoActionSheetAction(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: theme.textTheme.bodyLarge,
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
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          options[i].label,
                          style: options[i].selected
                              ? theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )
                              : theme.textTheme.bodyMedium!,
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
          );
        },
      );
}
