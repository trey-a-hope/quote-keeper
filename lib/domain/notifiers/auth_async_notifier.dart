import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/domain/models/users/user_model.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class AuthAsyncNotifier extends AsyncNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _userService = UserService();
  final _bookService = BookService();
  final _getStorage = GetStorage();

  AuthAsyncNotifier() : super() {
    _auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          state = const AsyncData(null);
        } else {
          _prepareUser(user);
        }
      },
    );
  }

  Future _prepareUser(User user) async {
    // Set UID to storage for persistence.
    await _getStorage.write('uid', user.uid);

    // Check if the user already exists.
    bool userExists = await _userService.checkIfUserExists(uid: user.uid);

    // Records a user ID (identifier) that's associated with subsequent fatal and non-fatal reports.
    await FirebaseCrashlytics.instance.setUserIdentifier(user.uid);

    if (userExists) {
      // TODO: Push Notifications currently throwing error in production.
      // // Request permission from user to receive push notifications.
      // if (Platform.isIOS) {
      //   await _firebaseMessaging.requestPermission();
      // }

      // // Fetch the fcm token for this device.
      // String? token = await _firebaseMessaging.getToken();

      // // Update fcm token for this device in firestore.
      // if (token != null) {
      //   _userService.updateUser(uid: user.uid, data: {'fcmToken': token});
      // }
    } else {
      // Build new user model.
      UserModel newUser = UserModel(
        imgUrl: user.photoURL ?? Globals.dummyProfilePhotoUrl,
        created: DateTime.now().toUtc(),
        modified: DateTime.now().toUtc(),
        uid: user.uid,
        username: user.displayName ?? user.email ?? 'NO USERNAME ASSIGNED',
        email: user.email ?? '',
        tutorialComplete: false,
      );

      // Create new user in firestore.
      await _userService.createUser(user: newUser);
    }

    state = AsyncData(user);
  }

  @override
  User? build() => _auth.currentUser;

  Future<UserModel> getCurrentUser() async {
    var user = state.value;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return await _userService.retrieveUser(uid: user.uid);
  }

  Future<void> deleteAccount() async {
    var user = state.value;

    if (user == null) {
      throw Exception('User is not logged in.');
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
