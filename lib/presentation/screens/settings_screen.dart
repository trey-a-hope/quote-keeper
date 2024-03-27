import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:quote_keeper/data/services/feedback_service.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/custom_list_tile_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modalService = ModalService();
    final feedbackService = FeedbackService();

    final authAsyncNotifier = ref.read(Providers.authAsyncProvider.notifier);

    final user = ref.read(Providers.userAsyncProvider);

    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'Settings',
        implyLeading: false,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                Globals.lottie.booksStacked,
              ),
            ),
            CustomListTileWidget(
              icon: Icons.info,
              title: 'About',
              callback: () => context.goNamed(Globals.routes.about),
              context: context,
            ),
            CustomListTileWidget(
              icon: Icons.bug_report,
              title: 'Give Feedback',
              callback: () => BetterFeedback.of(context).show(
                (UserFeedback ufb) async {
                  try {
                    await feedbackService.create(ufb, user.value!.uid);
                  } catch (e) {
                    if (!context.mounted) return;
                    modalService.showAlert(
                      context: context,
                      title: 'Error',
                      message: e.toString(),
                    );
                  }
                },
              ),
              context: context,
            ),
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
                if (!user.hasValue || user.value == null) {
                  return;
                }

                if (!context.mounted) return;

                bool? confirm = await modalService.showInputMatchConfirmation(
                  context: context,
                  title: 'Delete Account?',
                  hintText: 'Enter your email to confirm.',
                  match: user.value!.email,
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
            ),
          ],
        ),
      ),
    );
  }
}
