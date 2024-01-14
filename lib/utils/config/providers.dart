import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/domain/notifiers/books_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/create_book_notifier.dart';
import 'package:quote_keeper/domain/notifiers/dashboard_book_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/edit_book_notifier.dart';
import 'package:quote_keeper/domain/notifiers/search_books_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/should_display_tutorial_state_notifier.dart';
import 'package:quote_keeper/domain/notifiers/total_books_count_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote_keeper/domain/notifiers/auth_async_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/utils/config/app_routes.dart';

class Providers {
  static final authAsyncNotifierProvider =
      AsyncNotifierProvider<AuthAsyncNotifier, User?>(
    AuthAsyncNotifier.new,
  );

  static final booksAsyncNotifierProvider =
      AsyncNotifierProvider<BooksAsyncNotifier, List<BookModel>>(
    BooksAsyncNotifier.new,
  );

  static final createBookNotifierProvider =
      NotifierProvider<CreateBookNotifier, BookModel?>(
    CreateBookNotifier.new,
  );

  static final dashboardBookAsyncNotifierProvider =
      AsyncNotifierProvider<DashboardBookAsyncNotifier, BookModel?>(
          DashboardBookAsyncNotifier.new);

  static final editBookNotifierProvider =
      NotifierProvider<EditBookNotifier, BookModel?>(
    EditBookNotifier.new,
  );

  static final searchBooksAsyncNotifierProvider = AsyncNotifierProvider<
      SearchBooksAsyncNotifier,
      List<SearchBooksResultModel>>(SearchBooksAsyncNotifier.new);

  static final tutorialCompleteStateNotifierProvider =
      StateNotifierProvider<TutorialCompleteStateNotifier, bool>(
    (ref) => TutorialCompleteStateNotifier(),
  );

  static final totalBooksCountStateNotifierProvider =
      StateNotifierProvider<TotalBooksCountStateNotifier, int>(
    (ref) => TotalBooksCountStateNotifier(),
  );

  static final routerProvider = Provider<GoRouter>(
    (ref) {
      final authAsyncNotifierProvider =
          ref.watch(Providers.authAsyncNotifierProvider);
      final isAuthenticated = authAsyncNotifierProvider.value != null;
      return appRoutes(isAuthenticated);
    },
  );
}
