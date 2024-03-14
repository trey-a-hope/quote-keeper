import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/navigation_container.dart';
import 'package:quote_keeper/domain/models/book_model.dart';
import 'package:quote_keeper/domain/models/search_books_result_model.dart';
import 'package:quote_keeper/presentation/screens/about_screen.dart';
import 'package:quote_keeper/presentation/screens/create_quote_screen.dart';
import 'package:quote_keeper/presentation/screens/edit_profile_screen.dart';
import 'package:quote_keeper/presentation/screens/edit_quote_screen.dart';
import 'package:quote_keeper/presentation/screens/login_screen.dart';
import 'package:quote_keeper/presentation/screens/search_books_screen.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

GoRouter appRoutes(bool isAuthenticated) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/${Globals.routes.navigationContainer}',
    routes: [
      GoRoute(
        path: '/${Globals.routes.login}',
        name: Globals.routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/${Globals.routes.navigationContainer}',
        name: Globals.routes.navigationContainer,
        builder: (context, state) => const NavigationContainer(),
        routes: [
          GoRoute(
            path: Globals.routes.searchBooks,
            name: Globals.routes.searchBooks,
            builder: (context, state) => const SearchBooksScreen(),
            routes: [
              GoRoute(
                path: '${Globals.routes.createQuote}/:searchBooksResult',
                name: Globals.routes.createQuote,
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
            path: '${Globals.routes.editQuote}/:book',
            name: Globals.routes.editQuote,
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

              return EditQuoteScreen(book);
            },
          ),
          GoRoute(
            path: Globals.routes.editProfile,
            name: Globals.routes.editProfile,
            builder: (context, state) => EditProfileScreen(),
          ),
          GoRoute(
            path: Globals.routes.about,
            name: Globals.routes.about,
            builder: (context, state) => const AboutScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) =>
        isAuthenticated ? null : '/${Globals.routes.login}',
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
