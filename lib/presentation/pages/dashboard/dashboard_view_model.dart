import 'package:book_quotes/models/books/book_model.dart';
import 'package:book_quotes/services/book_service.dart';
import 'package:book_quotes/services/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final GetStorage _getStorage = Get.find();
  final UserService _userService = Get.find();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  BookModel? book;

  @override
  void onInit() async {
    super.onInit();

    await load();
  }

  Future load() async {
    try {
      String? fcmToken = await _firebaseMessaging.getToken();

      // Update fcm token for this device in firebase.
      if (fcmToken != null) {
        _userService.updateUser(
          uid: _getStorage.read('uid'),
          data: {'fcmToken': fcmToken},
        );
      }

      book = await _bookService.getRandom(
        uid: _getStorage.read('uid'),
      );

      update();
    } catch (e) {
      debugPrint('');
    }
  }
}
