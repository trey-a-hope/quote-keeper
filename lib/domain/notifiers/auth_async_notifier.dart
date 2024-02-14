import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/domain/models/user_model.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Firebase authentication listener.
class AuthAsyncNotifier extends AsyncNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _userService = UserService();
  final _bookService = BookService();

  @override
  User? build() => _auth.currentUser;

  AuthAsyncNotifier() : super() {
    _auth.authStateChanges().listen(
          (user) =>
              user == null ? state = const AsyncData(null) : _prepareUser(user),
        );
  }

  // Return the UID of current user; method should only be called if user is logged in.
  String getUid() {
    if (state.value == null) throw Exception('User is not logged in.');
    return state.value!.uid;
  }

  Future _prepareUser(User user) async {
    // Check if the user already exists.
    bool userExists = await _userService.checkIfUserExists(uid: user.uid);

    // Records a user ID (identifier) that's associated with subsequent fatal and non-fatal reports.
    await FirebaseCrashlytics.instance.setUserIdentifier(user.uid);

    if (userExists) {
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
      );

      // Create new user in firestore.
      await _userService.createUser(user: newUser);
    }

    state = AsyncData(user);
  }

  Future<void> deleteAccount() async {
    var user = state.value!;

    // Delete auth user.
    await user.delete();

    // Delete all books this user posted, as well as the user in firestore.
    await _bookService.deleteUserAndBooks(uid: user.uid);

    // Sign the user out one last time.
    await _auth.signOut();
  }

  Future<void> signOut() async {
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
        return Globals.googleSignInCancelError;
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
