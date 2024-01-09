import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/presentation/pages/search_books/search_books_view.dart';
import 'package:quote_keeper/presentation/screens/auth_checker_screen.dart';
import 'package:quote_keeper/presentation/screens/books_screen.dart';
import 'package:quote_keeper/presentation/screens/create_quote_screen.dart';
import 'package:quote_keeper/presentation/screens/dashboard_screen.dart';
import 'package:quote_keeper/presentation/screens/edit_book_screen.dart';
import 'package:quote_keeper/presentation/screens/settings_screen.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import '../../presentation/pages/login/login_view.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthCheckerScreen(),
    ),
    GoRoute(
      path: '/${Globals.routeLogin}',
      name: Globals.routeLogin,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/${Globals.routeDashboard}',
      name: Globals.routeDashboard,
      builder: (context, state) => DashboardScreen(),
      routes: [
        GoRoute(
          path: Globals.routeSearchBooks,
          name: Globals.routeSearchBooks,
          builder: (context, state) => SearchBooksView(),
          routes: [
            GoRoute(
              path: '${Globals.routeCreateQuote}/:searchBooksResult',
              name: Globals.routeCreateQuote,
              builder: (context, state) {
                final searchBooksResultJson =
                    jsonDecode(state.pathParameters['searchBooksResult']!);
                final searchBooksResult =
                    SearchBooksResultModel.fromJson(searchBooksResultJson);
                return CreateQuoteScreen(
                  searchBooksResult: searchBooksResult,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Globals.routeBooks,
          name: Globals.routeBooks,
          builder: (context, state) => const BooksScreen(),
          routes: [
            GoRoute(
              path: Globals.routeEditQuote,
              name: Globals.routeEditQuote,
              builder: (context, state) => EditBookScreen(),
            ),
          ],
        ),
        GoRoute(
          path: Globals.routeSettings,
          name: Globals.routeSettings,
          builder: (context, state) => SettingsScreen(),
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(
          'Page not found',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    ),
  ),
);
