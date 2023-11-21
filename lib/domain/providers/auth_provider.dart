import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/domain/models/users/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BookService _bookService = Get.find();
  final UserService _userService = Get.find();
  final GetStorage _getStorage = Get.find();

  Future<UserModel> getUser() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception();
    }

    return (await _userService.retrieveUser(uid: user.uid))!;
  }

  Future<void> deleteAccount() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception();
    }

    // Delete auth user.
    await user.delete();

    // Delete all books this user posted, as well as the user in firestore.
    await _bookService.deleteUserAndBooks(uid: user.uid);

    // Clear the uid from storage.
    await _getStorage.remove('uid');

    // Sign the user out one last time.
    _auth.signOut();
  }
}
