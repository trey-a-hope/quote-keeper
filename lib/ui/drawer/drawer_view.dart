import 'package:book_quotes/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'drawer_view_model.dart';

class DrawerView extends StatelessWidget {
  DrawerView({Key? key}) : super(key: key);
  final GetStorage _getStorage = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrawerViewModel>(
      init: DrawerViewModel(),
      builder: (model) => Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[],
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.person,
                ),
                title: Text(
                  'Profile',
                  style: context.theme.textTheme.headline5,
                ),
                onTap: () {
                  // Get.toNamed(Globals.routeProfile);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: context.theme.textTheme.headline5,
                ),
                onTap: () {
                  // Get.toNamed(Globals.routeSettings);
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Logout',
                  style: context.theme.textTheme.headline5,
                ),
                leading: const Icon(
                  Icons.logout,
                ),
                onTap: () async {
                  // /// Ask user if they're sure about log out.
                  // bool? confirm = await _modalService.showConfirmation(
                  //   context: context,
                  //   title: 'Logout',
                  //   message: 'Are you sure?',
                  // );
                  // if (confirm == null || confirm) {
                  //   try {
                  //     await model.logout();
                  //   } catch (error) {
                  //     Get.showSnackbar(
                  //       GetSnackBar(
                  //         title: 'Error',
                  //         message: error.toString(),
                  //         backgroundColor: Colors.red,
                  //         icon: const Icon(Icons.error),
                  //         duration: const Duration(seconds: 3),
                  //       ),
                  //     );
                  //   }
                  // }
                },
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Version ${_getStorage.read(Globals.appVersion)} + ${_getStorage.read(Globals.appBuildNumber)}',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
