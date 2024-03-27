import 'package:quote_keeper/domain/models/book_model.dart';
import 'package:quote_keeper/domain/models/search_books_result_model.dart';
import 'package:quote_keeper/domain/models/user_model.dart';
import 'package:quote_keeper/domain/notifiers/book_search_descending_notifier.dart';
import 'package:quote_keeper/domain/notifiers/book_search_term_notifier.dart';
import 'package:quote_keeper/domain/notifiers/books_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/create_book_notifier.dart';
import 'package:quote_keeper/domain/notifiers/dashboard_quote_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/most_recent_quotes_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/quotes_this_month_count_state_notifier.dart';
import 'package:quote_keeper/domain/notifiers/quotes_this_week_count_state_notifier.dart';
import 'package:quote_keeper/domain/notifiers/quotes_this_year_count_state_notifier.dart';
import 'package:quote_keeper/domain/notifiers/search_books_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/search_quotes_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/tutorial_complete_async_notifier.dart';
import 'package:quote_keeper/domain/notifiers/quotes_all_time_count_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote_keeper/domain/notifiers/auth_async_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/domain/notifiers/user_async_notifier.dart';
import 'package:quote_keeper/utils/config/app_routes.dart';

class Providers {
  static final authAsyncProvider =
      AsyncNotifierProvider<AuthAsyncNotifier, User?>(
    AuthAsyncNotifier.new,
  );

  static final booksAsyncProvider =
      AsyncNotifierProvider.autoDispose<BooksAsyncNotifier, List<BookModel>>(
    BooksAsyncNotifier.new,
  );

  static final bookSearchIsDescendingProvider =
      NotifierProvider.autoDispose<BookSearchIsDescendingNotifier, bool>(
    BookSearchIsDescendingNotifier.new,
  );

  static final bookSearchTermProvider =
      NotifierProvider.autoDispose<BookSearchTermNotifier, BookSearchTerm>(
    BookSearchTermNotifier.new,
  );

  static final createBookProvider =
      NotifierProvider.autoDispose<CreateBookNotifier, BookModel?>(
    CreateBookNotifier.new,
  );

  static final dashboardQuoteAsyncProvider = AsyncNotifierProvider.autoDispose<
      DashboardQuoteAsyncNotifier, BookModel?>(DashboardQuoteAsyncNotifier.new);

  static final mostRecentQuotesAsyncProvider = AsyncNotifierProvider
      .autoDispose<MostRecentQuotesAsyncNotifier, List<BookModel>?>(
    MostRecentQuotesAsyncNotifier.new,
  );

  static final quotesAllTimeCountAsyncProvider =
      AsyncNotifierProvider.autoDispose<QuotesAllTimeCountAsyncNotifier, int>(
    QuotesAllTimeCountAsyncNotifier.new,
  );

  static final quotesThisMonthCountStateProvider =
      AsyncNotifierProvider.autoDispose<QuotesThisMonthCountStateNotifier, int>(
    QuotesThisMonthCountStateNotifier.new,
  );

  static final quotesThisWeekCountStateProvider =
      AsyncNotifierProvider.autoDispose<QuotesThisWeekCountStateNotifier, int>(
    QuotesThisWeekCountStateNotifier.new,
  );

  static final quotesThisYearCountStateProvider =
      AsyncNotifierProvider.autoDispose<QuotesThisYearCountStateNotifier, int>(
    QuotesThisYearCountStateNotifier.new,
  );

  static final routerProvider = Provider<GoRouter>(
    (ref) {
      final authAsyncProvider = ref.watch(Providers.authAsyncProvider);
      final isAuthenticated = authAsyncProvider.value != null;
      return appRoutes(isAuthenticated);
    },
  );

  static final searchBooksAsyncProvider = AsyncNotifierProvider.autoDispose<
      SearchBooksAsyncNotifier,
      List<SearchBooksResultModel>>(SearchBooksAsyncNotifier.new);

  static final searchQuotesAsyncProvider = AsyncNotifierProvider.autoDispose<
      SearchQuotesAsyncNotifier, List<BookModel>>(
    SearchQuotesAsyncNotifier.new,
  );

  static final tutorialCompleteStateProvider =
      AsyncNotifierProvider.autoDispose<TutorialCompleteAsyncNotifier, bool>(
    TutorialCompleteAsyncNotifier.new,
  );

  static final userAsyncProvider =
      AsyncNotifierProvider<UserAsyncNotifier, UserModel?>(
    UserAsyncNotifier.new,
  );
}
