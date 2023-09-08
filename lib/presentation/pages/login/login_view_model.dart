part of 'login_view.dart';

class _LoginViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
