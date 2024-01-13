import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/domain/models/users/user_model.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Firebase authentication listener.
class AuthAsyncNotifier extends AsyncNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _userService = UserService();
  final _bookService = BookService();
  final _getStorage = GetStorage();

  @override
  User? build() => _auth.currentUser;

  AuthAsyncNotifier() : super() {
    _auth.authStateChanges().listen(
          (user) =>
              user == null ? state = const AsyncData(null) : _prepareUser(user),
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

  Future<UserModel> getCurrentUser() async =>
      await _userService.retrieveUser(uid: state.value!.uid);

  Future<void> deleteAccount() async {
    // Delete auth user.
    await state.value!.delete();

    // Delete all books this user posted, as well as the user in firestore.
    await _bookService.deleteUserAndBooks(uid: state.value!.uid);

    // Clear the uid from storage.
    await _getStorage.remove('uid');

    // Sign the user out one last time.
    await _auth.signOut();
  }

  Future<void> signOut() async {
    // Clear the uid from storage.
    await _getStorage.remove('uid');

    // Sign the user out.
    await _auth.signOut();
  }

  Future<String?> recoverPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> loginEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If user cancels selection, throw error to prevent null check below.
      if (googleUser == null) {
        return 'Must select a Google Account.';
        // throw Exception('Must select a Google Account.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> appleSignIn() async {
    try {
      // Trigger the authentication flow.
      final AuthorizationCredentialAppleID appleIdCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Created credential from id credential.
      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleIdCredential.identityToken!,
        accessToken: appleIdCredential.authorizationCode,
      );

      // Once signed in, return the UserCredential.
      await _auth.signInWithCredential(credential);

      return null;
    } catch (error) {
      return error.toString();
    }
  }
}
