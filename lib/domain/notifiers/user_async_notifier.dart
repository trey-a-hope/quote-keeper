import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/domain/models/user_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class UserAsyncNotifier extends AsyncNotifier<UserModel?> {
  final _userService = UserService();

  @override
  FutureOr<UserModel?> build() async {
    // Listen to changes with authencation to the app.
    final authUser = ref.watch(Providers.authAsyncProvider);

    // If user is not logged in, return null.
    if (!authUser.hasValue || authUser.value == null) {
      return null;
    }

    // Fetch firegstore user.
    final user = await _userService.retrieveUser(uid: authUser.value!.uid);

    return user;
  }

  void updateUser(Map<String, dynamic> data) async {
    final String newUsername = data['username'];

    // Update username on BE.
    await _userService.updateUser(
      uid: ref.read(Providers.authAsyncProvider.notifier).getUid(),
      data: {
        'username': newUsername,
      },
    );

    // Update username on FE.
    var user = state.value!;

    user = user.copyWith(username: newUsername);

    state = AsyncData(user);
  }
}
