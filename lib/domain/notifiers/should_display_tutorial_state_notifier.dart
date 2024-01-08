import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/user_service.dart';

class ShouldDisplayTutorialStateNotifier extends StateNotifier<bool> {
  final UserService _userService = Get.find();

  final GetStorage _getStorage = Get.find();

  late String _uid;

  ShouldDisplayTutorialStateNotifier() : super(false) {
    _uid = _getStorage.read('uid');
    shouldDisplayTutorial();
  }

  Future<void> shouldDisplayTutorial() async {
    var user = await _userService.retrieveUser(uid: _uid);
    state = !user.tutorialComplete;
  }

  void setShouldDisplayTutorial(bool value) {
    state = value;
  }
}
