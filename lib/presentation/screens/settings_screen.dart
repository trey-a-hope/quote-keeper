import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/custom_list_tile_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modalService = ModalService();

    final authAsyncNotifier =
        ref.read(Providers.authAsyncNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'Settings',
        implyLeading: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomListTileWidget(
                icon: Icons.logout,
                title: 'Logout',
                callback: () async {
                  bool? confirm = await modalService.showConfirmation(
                    context: context,
                    title: 'Logout',
                    message: 'Are you sure?',
                  );

                  if (confirm == null || confirm == false) {
                    return;
                  }

                  await authAsyncNotifier.signOut();
                },
                context: context,
              ),
              CustomListTileWidget(
                icon: Icons.delete,
                title: 'Delete Account',
                callback: () async {
                  final user = await authAsyncNotifier.getCurrentUser();

                  if (!context.mounted) return;

                  bool? confirm = await modalService.showInputMatchConfirmation(
                    context: context,
                    title: 'Delete Account?',
                    hintText: 'Enter your email to confirm.',
                    match: user.email,
                  );

                  if (confirm == null || confirm == false) {
                    return;
                  }

                  try {
                    await authAsyncNotifier.deleteAccount();
                  } catch (e) {
                    if (!context.mounted) return;

                    modalService.showAlert(
                      context: context,
                      title: 'Error',
                      message: e.toString(),
                    );
                  }
                },
                context: context,
              )
            ],
          ),
        ),
      ),
    );
  }
}
