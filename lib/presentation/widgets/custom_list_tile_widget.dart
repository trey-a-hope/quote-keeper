import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? callback;
  final bool? isDarkMode;
  final BuildContext context;

  const CustomListTileWidget(
      {Key? key,
      required this.icon,
      required this.title,
      this.callback,
      this.isDarkMode,
      required this.context})
      : super(key: key);

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
      title: Text(title, style: const TextStyle(fontSize: 17)),
      trailing: isDarkMode == true
          ? CupertinoSwitch(
              thumbColor: Colors.blue,
              activeColor: Colors.green,
              trackColor: Colors.black,
              // value: vm.isDark,
              onChanged: (v) {
                // vm.setPref(v);
                // vm.getPref();
                // vm.setToDark();
              },
              value: true,
            )
          : Icon(
              CupertinoIcons.arrow_right,
              color: Colors.grey,
            ),
      onTap: callback,
    );
  }
}
