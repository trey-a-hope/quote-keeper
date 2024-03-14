import 'package:flutter_animate/flutter_animate.dart';

class Globals {
  Globals._();

  static late String version;
  static late String buildNumber;

  static final algolia = _AlgoliaConfig();
  static final effects = _Effects();
  static final googleAPIKeys = _GoogleAPIKeys();
  static final labels = _Labels();
  static final lottie = _Lottie();
  static final networkImages = _NetworkImages();
  static final routes = _Routes();
}

class _AlgoliaConfig {
  final String appId = '5YW6LL0ZS7';
  final String apiKey = '4705c4904923eacfa4e2a3ec7b3a4847';
  final String booksIndex = 'books';
}

class _Effects {
  final List<Effect<dynamic>> fade = <Effect>[
    FadeEffect(duration: 300.ms),
  ];
}

class _GoogleAPIKeys {
  final String booksAPIKey = 'AIzaSyB3fwTeLyIoErtbZjqj9WWlooi6Hhf5KO0';
  final String cloudMessagingServerKey =
      'AAAAzo15CQU:APA91bH040ySf7LL4P-m68WqWqY3uVPeQspn93KZq3335E-K4e3UhkD9jX6m27xKB1P9IG7XIfVwL5evi59TJOyLioIilO3G0ea5NEELUEe0VciUGV-pRg3phNHGPntVnx_DszYPnzmP';
}

class _Labels {
  final String enterBookTitle = 'Enter book title here...';
}

class _Lottie {
  final String books = 'assets/lotties/books.json';
}

class _NetworkImages {
  final String libraryBackground =
      'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGlicmFyeSUyMGJhY2tncm91bmR8ZW58MHx8MHx8fDA%3D&w=1000&q=80MGJhY2tncm91bmR8ZW58MHx8MHx8fDA%253D%26w%3D1000%26q%3D80%22&aqs=chrome..69i57.393j0j7&sourceid=chrome&ie=UTF-8';
  final String dummyProfile =
      'https://firebasestorage.googleapis.com/v0/b/critic-a9e44.appspot.com/o/Images%2FProfile.jpeg?alt=media&token=f8d67c2f-9b1c-4cbe-aca5-6da014c504a0';
}

class _Routes {
  final String about = 'about';
  final String authChecker = 'authChecker';
  final String books = 'books';
  final String createQuote = 'createQuote';
  final String dashboard = 'dashboard';
  final String editQuote = 'editQuote';
  final String editProfile = 'editProfile';
  final String login = 'login';
  final String navigationContainer = 'navigationContainer';
  final String searchBooks = 'searchBooks';
  final String settings = 'settings';
  final String splash = 'splash';
}
