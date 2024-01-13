import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/presentation/widgets/qk_scaffold_widget.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class SettingsScreen extends ConsumerWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final _modalService = ModalService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsyncNotifier =
        ref.read(Providers.authAsyncNotifierProvider.notifier);

    final searchBooksAsyncNotifier =
        ref.read(Providers.searchBooksAsyncNotifierProvider.notifier);

    return QKScaffoldWidget(
      title: 'Settings',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => context.pop(),
      ),
      child: SettingsList(
        backgroundColor: Colors.white,
        sections: [
          SettingsSection(
            title: 'About',
            tiles: [
              SettingsTile(
                title: 'Version',
                leading: Icon(
                  Icons.numbers,
                  color: Theme.of(context).iconTheme.color,
                ),
                trailing: Text(Globals.version),
              ),
              SettingsTile(
                title: 'Build Number',
                leading: Icon(
                  Icons.build,
                  color: Theme.of(context).iconTheme.color,
                ),
                trailing: Text(Globals.buildNumber),
              ),
            ],
          ),
          SettingsSection(
            title: 'Profile',
            tiles: [
              SettingsTile(
                title: 'Logout',
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).iconTheme.color,
                ),
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

                  searchBooksAsyncNotifier.clear();

                  await authAsyncNotifier.signOut();
                },
              ),
              SettingsTile(
                title: 'Delete Account',
                leading: Icon(
                  Icons.delete,
                  color: Theme.of(context).iconTheme.color,
                ),
                trailing: const Icon(Icons.chevron_right),
                onPressed: (_) async {
                  final user = await authAsyncNotifier.getCurrentUser();

                  if (!context.mounted) return;

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
                    searchBooksAsyncNotifier.clear();

                    await authAsyncNotifier.deleteAccount();
                  } catch (e) {
                    if (!context.mounted) return;

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
