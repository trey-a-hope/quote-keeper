import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/user_service.dart';

// Whether or not to display the tutorial.
class TutorialCompleteStateNotifier extends StateNotifier<bool> {
  final _userService = UserService();

  final _getStorage = GetStorage();

  late String _uid;

  TutorialCompleteStateNotifier() : super(false) {
    _uid = _getStorage.read('uid');
    shouldDisplayTutorial();
  }

  Future<void> shouldDisplayTutorial() async {
    var user = await _userService.retrieveUser(uid: _uid);
    state = user.tutorialComplete;
  }

  void markTutorialComplete() async {
    await _userService.updateUser(
      uid: _uid,
      data: {
        'tutorialComplete': true,
      },
    );

    state = true;
  }
}
