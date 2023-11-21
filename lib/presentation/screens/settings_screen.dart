import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:get/get.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/domain/models/users/user_model.dart';
import 'package:quote_keeper/domain/providers/auth_provider.dart';
import 'package:quote_keeper/domain/providers/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class SettingsScreen extends ConsumerWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final ModalService _modalService = Get.find();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthProvider authProvider = ref.watch(Providers.authProvider);

    return SimplePageWidget(
      title: 'Settings',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => Get.back(),
      ),
      child: SettingsList(
        backgroundColor: Colors.white,
        sections: [
          SettingsSection(
            title: 'About',
            tiles: [
              SettingsTile(
                title: 'Version',
                leading: const Icon(Icons.numbers),
                trailing: Text(Globals.version),
              ),
              SettingsTile(
                title: 'Build Number',
                leading: const Icon(Icons.build),
                trailing: Text(Globals.buildNumber),
              ),
            ],
          ),
          SettingsSection(
            title: 'Profile',
            tiles: [
              SettingsTile(
                title: 'Logout',
                leading: const Icon(Icons.logout),
                trailing: const Icon(Icons.chevron_right),
                onPressed: (_) async {
                  bool? confirm = await _modalService.showConfirmation(
                    context: context,
                    title: 'Logout',
                    message: 'Are you sure?',
                  );

                  if (confirm == null || confirm == false) {
                    return;
                  }

                  FirebaseAuth.instance.signOut();
                },
              ),
              SettingsTile(
                title: 'Delete Account',
                leading: const Icon(Icons.delete),
                trailing: const Icon(Icons.chevron_right),
                onPressed: (_) async {
                  UserModel user = await authProvider.getUser();

                  bool? confirm =
                      await _modalService.showInputMatchConfirmation(
                    context: context,
                    title: 'Delete Account?',
                    hintText: 'Enter your email to confirm.',
                    match: user.email,
                  );

                  if (confirm == null || confirm == false) {
                    return;
                  }

                  try {
                    await authProvider.deleteAccount();
                  } catch (e) {
                    _modalService.showAlert(
                      context: context,
                      title: 'Error',
                      message: e.toString(),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
