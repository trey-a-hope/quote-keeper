import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';

// Whether or not to display the tutorial.
class TutorialCompleteStateNotifier extends AsyncNotifier<bool> {
  final _userService = UserService();

  @override
  FutureOr<bool> build() async => (await ref
          .read(Providers.authAsyncNotifierProvider.notifier)
          .getCurrentUser())
      .tutorialComplete;

  void markTutorialComplete() async {
    await _userService.updateUser(
      uid: ref.read(Providers.authAsyncNotifierProvider.notifier).getUid(),
      data: {
        'tutorialComplete': true,
      },
    );

    state = const AsyncData(true);
  }
}
