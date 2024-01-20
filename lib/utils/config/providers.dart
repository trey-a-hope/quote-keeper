import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/domain/models/users/user_model.dart';
import 'package:quote_keeper/domain/notifiers/books_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/create_book_notifier.dart';
import 'package:quote_keeper/domain/notifiers/quote_of_the_day_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/most_recent_quotes_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/search_books_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/search_quotes_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/tutorial_complete_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/total_books_count_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote_keeper/domain/notifiers/auth_async_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/domain/notifiers/user_async_notifier.dart';
import 'package:quote_keeper/utils/config/app_routes.dart';

class Providers {
  static final authAsyncNotifierProvider =
      AsyncNotifierProvider<AuthAsyncNotifier, User?>(
    AuthAsyncNotifier.new,
  );

  static final booksAsyncNotifierProvider =
      AsyncNotifierProvider.autoDispose<BooksAsyncNotifier, List<BookModel>>(
    BooksAsyncNotifier.new,
  );

  static final createBookNotifierProvider =
      NotifierProvider.autoDispose<CreateBookNotifier, BookModel?>(
    CreateBookNotifier.new,
  );

  static final quoteOfTheDayAsyncNotifierProvider =
      AsyncNotifierProvider.autoDispose<QuoteOfTheDayAsyncNotifier, BookModel?>(
          QuoteOfTheDayAsyncNotifier.new);

  static final mostRecentQuotesAsyncNotifierProvider = AsyncNotifierProvider
      .autoDispose<MostRecentQuotesAsyncNotifier, List<BookModel>?>(
    MostRecentQuotesAsyncNotifier.new,
  );

  static final routerProvider = Provider<GoRouter>(
    (ref) {
      final authAsyncNotifierProvider =
          ref.watch(Providers.authAsyncNotifierProvider);
      final isAuthenticated = authAsyncNotifierProvider.value != null;
      return appRoutes(isAuthenticated);
    },
  );

  static final searchBooksAsyncNotifierProvider =
      AsyncNotifierProvider.autoDispose<SearchBooksAsyncNotifier,
          List<SearchBooksResultModel>>(SearchBooksAsyncNotifier.new);

  static final searchQuotesAsyncNotifierProvider = AsyncNotifierProvider
      .autoDispose<SearchQuotesAsyncNotifier, List<BookModel>>(
    SearchQuotesAsyncNotifier.new,
  );

  static final tutorialCompleteStateNotifierProvider =
      AsyncNotifierProvider.autoDispose<TutorialCompleteAsyncNotifier, bool>(
    TutorialCompleteAsyncNotifier.new,
  );

  static final totalBooksCountAsyncNotifierProvider =
      AsyncNotifierProvider.autoDispose<TotalBooksCountAsyncNotifier, int>(
    TotalBooksCountAsyncNotifier.new,
  );

  static final userAsyncNotifierProvider =
      AsyncNotifierProvider<UserAsyncNotifier, UserModel?>(
    UserAsyncNotifier.new,
  );
}
