import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/presentation/screens/books_screen.dart';
import 'package:quote_keeper/presentation/screens/create_quote_screen.dart';
import 'package:quote_keeper/presentation/screens/dashboard_screen.dart';
import 'package:quote_keeper/presentation/screens/edit_book_screen.dart';
import 'package:quote_keeper/presentation/screens/login_screen.dart';
import 'package:quote_keeper/presentation/screens/search_books_screen.dart';
import 'package:quote_keeper/presentation/screens/settings_screen.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

GoRouter appRoutes(bool isAuthenticated) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/${Globals.routeDashboard}',
    routes: [
      GoRoute(
        path: '/${Globals.routeLogin}',
        name: Globals.routeLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/${Globals.routeDashboard}',
        name: Globals.routeDashboard,
        builder: (context, state) => DashboardScreen(),
        routes: [
          GoRoute(
            path: Globals.routeSearchBooks,
            name: Globals.routeSearchBooks,
            builder: (context, state) => SearchBooksScreen(),
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
                path: '${Globals.routeEditQuote}/:book',
                name: Globals.routeEditQuote,
                builder: (context, state) {
                  final bookJson = jsonDecode(state.pathParameters['book']!);

                  // Note: Conversion between String and Timestamp since Timestamp can't be encodded.
                  bookJson['created'] = Timestamp.fromDate(
                    DateTime.parse(
                      bookJson['created'],
                    ),
                  );
                  bookJson['modified'] = Timestamp.fromDate(
                    DateTime.parse(
                      bookJson['modified'],
                    ),
                  );

                  final book = BookModel.fromJson(bookJson);

                  return EditBookScreen(book);
                },
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
    redirect: (context, state) =>
        isAuthenticated ? null : '/${Globals.routeLogin}',
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
}
