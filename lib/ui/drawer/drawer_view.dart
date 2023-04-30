import 'package:book_quotes/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
            children: [
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Welcome back Trey',
                              textAlign: TextAlign.center,
                              style: context.textTheme.headline4,
                            ),
                          ),
                        )
                      ],
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(Globals.dummyProfilePhotoUrl),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: Text(
                  'Books',
                  style: context.theme.textTheme.headline5,
                ),
                onTap: () {
                  Get.toNamed(Globals.routeQuotes);
                },
              ),
              const Spacer(),
              const Divider(),
              Center(
                child: Text(
                  'Version ${Globals.version!} + ${Globals.buildNumber!}',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
