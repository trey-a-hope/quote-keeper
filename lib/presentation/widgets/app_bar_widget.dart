import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget {
  static AppBar appBar({
    required String title,
    required bool implyLeading,
    required BuildContext context,
    Widget? action,
  }) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 18),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: implyLeading == true
          ? Transform.scale(
              scale: 0.7,
              child: IconButton(
                icon: const Icon(
                  Icons.keyboard_backspace_rounded,
                  size: 33,
                  color: Colors.grey,
                ),
                onPressed: () => context.pop(),
              ),
            )
          : const SizedBox(),
      actions: [
        if (action != null) ...[
          action,
          const Gap(15),
        ]
      ],
    );
  }
}
