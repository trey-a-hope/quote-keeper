import 'package:book_quotes/constants/globals.dart';
import 'package:book_quotes/ui/create_quote/create_quote_view.dart';
import 'package:book_quotes/ui/dashboard/dashboard_view.dart';
import 'package:book_quotes/ui/quotes/quotes_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  AppRoutes._();

  static final List<GetPage> routes = [
    GetPage(
      name: Globals.routeCreateQuote,
      page: () => CreateQuoteView(),
    ),
    GetPage(
      name: Globals.routeDashboard,
      page: () => DashboardView(),
    ),
    GetPage(
      name: Globals.routeQuotes,
      page: () => const QuotesView(),
    ),
  ];
}
