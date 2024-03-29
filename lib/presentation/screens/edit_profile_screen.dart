import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/qk_full_button.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/toast_type.dart';

class EditProfileScreen extends ConsumerWidget {
  final _usernameController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.read(Providers.userAsyncProvider).when(
            data: (user) {
              if (user == null) {
                throw Exception('User is null');
              }

              _usernameController.text = user.username;

              return Scaffold(
                appBar: AppBarWidget.appBar(
                  title: 'Edit Profile',
                  implyLeading: true,
                  context: context,
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Gap(10),
                            Text(
                              'Username',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return TextFormField(
                                onChanged: (val) {
                                  _usernameController.text = val;
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .color,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _usernameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .color,
                                ),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color),
                                  counterStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color),
                                ),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        QKFullButton(
                          iconData: Icons.check,
                          label: 'SAVE',
                          onTap: () => _submitForm(context, ref),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) => Text(
              error.toString(),
            ),
            loading: () => const CircularProgressIndicator(),
          );

  void _submitForm(BuildContext context, WidgetRef ref) async {
    if (_usernameController.text.isEmpty) {
      ModalService.showToast(
        context: context,
        message: 'Username cannot be empty.',
        toastType: ToastType.failure,
      );

      return;
    }

    bool? confirm = await ModalService.showConfirmation(
      context: context,
      title: 'Update Profile',
      message: 'Are you sure?',
    );

    if (confirm == null || confirm == false) {
      return;
    }

    try {
      ref.read(Providers.userAsyncProvider.notifier).updateUser({
        'username': _usernameController.text,
      });

      if (!context.mounted) return;

      ModalService.showToast(
        context: context,
        message: 'Username updated.',
      );
    } catch (e) {
      if (!context.mounted) return;

      ModalService.showToast(
        context: context,
        message: e.toString(),
        toastType: ToastType.failure,
      );
    }
  }
}
