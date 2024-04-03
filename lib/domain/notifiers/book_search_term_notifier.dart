import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Options for sorting a users quotes.
enum BookSearchTerm {
  title('Title', 'title'),
  created('Created', 'created'),
  modified('Modified', 'modified'),
  author('Author', 'author');

  const BookSearchTerm(this.label, this.query);

  final String label;
  final String query;
}

/// Holds the current query for searching quotes.
class BookSearchTermNotifier extends AutoDisposeNotifier<BookSearchTerm> {
  // Default the book search to sort by created value.
  @override
  BookSearchTerm build() => BookSearchTerm.created;

  // Update the book search term enum value.
  void updateTerm(BookSearchTerm term) => state = term;
}
