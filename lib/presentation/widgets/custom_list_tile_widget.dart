import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final BuildContext context;
  final VoidCallback? callback;
  final bool? isDarkMode;

  const CustomListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.context,
    this.callback,
    this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[700],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Theme.of(context).iconTheme.color!,
          size: 18,
        ),
      ),
      minLeadingWidth: 50,
      horizontalTitleGap: 13,
      title: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
      trailing: const Icon(
        CupertinoIcons.arrow_right,
        color: Colors.grey,
      ),
      onTap: callback,
    );
  }
}
