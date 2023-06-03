part of 'main_view.dart';

class _MainViewModel extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rxn<User> firebaseUserObs = Rxn<User>();

  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('users');

  final UserService _userService = Get.find();

  final GetStorage _getStorage = Get.find();

  @override
  void onReady() async {
    // Run every time auth state changes
    ever(firebaseUserObs, handleAuthChanged);

    firebaseUserObs.bindStream(user);

    super.onReady();
  }

  /// Listens for user auth changes.
  handleAuthChanged(firebaseUser) async {
    // final VersionStatus? status = await NewVersionPlus().getVersionStatus();
    if (firebaseUser == null /*|| (status != null && status.canUpdate)*/) {
      Get.offAllNamed(Globals.routeLogin);
    }
    // Proceed to home page.
    else {
      // Get user document reference.
      DocumentReference userDocRef = _usersDB.doc(firebaseUser.uid);

      // Check if user already exists.
      bool userExists = (await userDocRef.get()).exists;

      // Set UID to get storage.
      await _getStorage.write('uid', firebaseUser.uid);

      // Set app version and build number.
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _getStorage.write(Globals.appBuildNumber, packageInfo.buildNumber);
      _getStorage.write(Globals.appVersion, packageInfo.version);

      // // Records a user ID (identifier) that's associated with subsequent fatal and non-fatal reports.
      // await FirebaseCrashlytics.instance.setUserIdentifier(_firebaseUser.uid);

      if (userExists) {
        // Request permission from user to receive push notifications.
        if (Platform.isIOS) {
          _firebaseMessaging.requestPermission();
        }

        // Fetch the fcm token for this device.
        String? token = await _firebaseMessaging.getToken();

        // Update fcm token for this device in firebase.
        if (token != null) {
          userDocRef.update({'fcmToken': token});
        }
      } else {
        // Create user in firebase.
        UserModel user = UserModel(
          imgUrl: firebaseUser.photoURL ?? Globals.dummyProfilePhotoUrl,
          created: DateTime.now().toUtc(),
          modified: DateTime.now().toUtc(),
          uid: firebaseUser.uid,
          username: firebaseUser.displayName ?? firebaseUser.email,
          email: firebaseUser.email ?? '',
          bookIDs: [],
        );

        await _userService.createUser(user: user);
      }

      // Proceed to home page.
      Get.offAllNamed(Globals.routeDashboard);
    }
  }

  // Firebase user a realtime stream.
  Stream<User?> get user => _auth.authStateChanges();
}
