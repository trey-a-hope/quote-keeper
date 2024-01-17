import 'package:flutter_animate/flutter_animate.dart';
import 'package:new_version_plus/new_version_plus.dart';

class Globals {
  Globals._();

  static var algolia = _AlgoliaConfig();

  static const String googleSignInCancelError = 'Must select a Google Account.';

  /// Routes
  static const String routeNavigationContainer = 'navigationContainer';
  static const String routeBooks = 'books';
  static const String routeCreateQuote = 'createQuote';
  static const String routeDashboard = 'dashboard';
  static const String routeEditQuote = 'editQuote';
  static const String routeLogin = 'login';
  static const String routeAuthChecker = 'authChecker';
  static const String routeSplash = 'splash';
  static const String routeSearchBooks = 'searchBooks';
  static const String routeSettings = 'settings';

  /// Images
  static const String libraryBackground =
      'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGlicmFyeSUyMGJhY2tncm91bmR8ZW58MHx8MHx8fDA%3D&w=1000&q=80MGJhY2tncm91bmR8ZW58MHx8MHx8fDA%253D%26w%3D1000%26q%3D80%22&aqs=chrome..69i57.393j0j7&sourceid=chrome&ie=UTF-8';
  static const String dummyProfilePhotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/critic-a9e44.appspot.com/o/Images%2FProfile.jpeg?alt=media&token=f8d67c2f-9b1c-4cbe-aca5-6da014c504a0';

  /// API Keys
  static const String googleBooksAPIKey =
      'AIzaSyB3fwTeLyIoErtbZjqj9WWlooi6Hhf5KO0';
  static const String cloudMessagingServerKey =
      'AAAAzo15CQU:APA91bH040ySf7LL4P-m68WqWqY3uVPeQspn93KZq3335E-K4e3UhkD9jX6m27xKB1P9IG7XIfVwL5evi59TJOyLioIilO3G0ea5NEELUEe0VciUGV-pRg3phNHGPntVnx_DszYPnzmP';

  /// Dummy Variables

  static const String darkModeEnabled = 'dark_mode_enabled';

  static late String version;
  static late String buildNumber;

  static List<Effect<dynamic>> fadeEffect = <Effect>[
    FadeEffect(duration: 300.ms),
  ];

  static String splashMessage = 'Books are essential.';
  static String searchLabel = 'Enter book title here...';

  /// Package info
  static const String appVersion = 'app_version';
  static const String appBuildNumber = 'build_number';

  /// Book page fetch limit.
  static const int bookPageFetchLimit = 5;

  static NewVersionPlus newVersionPlus = NewVersionPlus(
    iOSId: 'com.example.book-quotes',
    androidId: 'com.io.book_quotes',
    androidPlayStoreCountry: "es_ES",
    androidHtmlReleaseNotes: true,
  );
}

class _AlgoliaConfig {
  final String appId = '5YW6LL0ZS7';
  final String apiKey = '4705c4904923eacfa4e2a3ec7b3a4847';
  final String booksIndex = 'books';
}
