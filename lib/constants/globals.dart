class Globals {
  Globals._();

  /// Routes
  static const String routeCreateFeeling = '/createFeeling';
  static const String routeCreateFeelingSuccess = '/createFeelingSuccess';
  static const String routeCreateInvite = '/createInvite';
  static const String routeEditProfile = '/editProfile';
  static const String routeFeelings = '/feelings';
  static const String routeFeelingsSettings = '/feelingsSettings';
  static const String routeDashboard = '/dashboard';
  static const String routeInvites = '/invites';
  static const String routeLogin = '/login';
  static const String routeMain = '/main';
  static const String routeProfile = '/profile';
  static const String routeRooms = '/rooms';
  static const String routeSettings = '/settings';
  static const String routeSearchUsers = '/searchUsers';

  /// Feelz API Endpoint
  static const String feelsAPIEndpoint = 'https://feelz-api.herokuapp.com/';

  /// Messages
  static const String splashMessage = 'What\'s on your mind?';

  /// Package info
  static const String appVersion = 'app_version';
  static const String appBuildNumber = 'build_number';

  static const int createFeelingCharLimit = 10;
  static const int questionCharLimit = 10;

  static const String cloudMessagingServerKey =
      'AAAAzo15CQU:APA91bH040ySf7LL4P-m68WqWqY3uVPeQspn93KZq3335E-K4e3UhkD9jX6m27xKB1P9IG7XIfVwL5evi59TJOyLioIilO3G0ea5NEELUEe0VciUGV-pRg3phNHGPntVnx_DszYPnzmP';

  /// Algolia API
  static const String algoliaAppID = 'NZMNPXT7F4';
  static const String algoliaSearchAPIKey = '685f04baeed61bafaad4145317e15d5c';

  /// Dummy Variables
  static const String dummyProfilePhotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/critic-a9e44.appspot.com/o/Images%2FProfile.jpeg?alt=media&token=f8d67c2f-9b1c-4cbe-aca5-6da014c504a0';

  static const String darkModeEnabled = 'dark_mode_enabled';

  /// Questionz
  static const String defaultQuestion1 =
      'What is something interesting that happened today?';
  static const String defaultQuestion2 = 'How is your mental?';
  static const String defaultQuestion3 =
      'What is something that stressed you out today?';
}
