import 'package:book_quotes/constants/globals.dart';
import 'package:book_quotes/ui/dashboard/dashboard_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  AppRoutes._();

  static final List<GetPage> routes = [
    // GetPage(
    //   name: '/',
    //   page: () => const SplashView(),
    // ),
    // GetPage(
    //   name: Globals.routeCreateFeeling,
    //   page: () => CreateFeelingView(),
    // ),
    // GetPage(
    //   name: Globals.routeCreateFeelingSuccess,
    //   page: () => CreateFeelingSuccessView(),
    // ),
    // GetPage(
    //   name: Globals.routeCreateInvite,
    //   page: () => CreateInviteView(),
    // ),
    // GetPage(
    //   name: Globals.routeEditProfile,
    //   page: () => EditProfileView(),
    // ),
    // GetPage(
    //   name: Globals.routeFeelings,
    //   page: () => FeelingsView(),
    // ),
    // GetPage(
    //   name: Globals.routeFeelingsSettings,
    //   page: () => FeelingsSettingsView(),
    // ),
    GetPage(
      name: Globals.routeDashboard,
      page: () => DashboardView(),
    ),
    // GetPage(
    //   name: Globals.routeInvites,
    //   page: () => InvitesView(),
    // ),
    // GetPage(
    //   name: Globals.routeLogin,
    //   page: () => const LoginView(),
    // ),
    // GetPage(
    //   name: Globals.routeMain,
    //   page: () => const MainView(),
    // ),
    // GetPage(
    //   name: Globals.routeProfile,
    //   page: () => const ProfileView(),
    // ),
    // GetPage(
    //   name: Globals.routeRooms,
    //   page: () => RoomsView(),
    // ),
    // GetPage(
    //   name: Globals.routeSearchUsers,
    //   page: () => SearchUsersView(),
    // ),
    // GetPage(
    //   name: Globals.routeSettings,
    //   page: () => SettingsView(),
    // ),
  ];
}
