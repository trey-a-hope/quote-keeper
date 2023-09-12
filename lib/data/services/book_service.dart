import 'dart:convert';

import 'package:book_quotes/domain/models/books/book_model.dart';
import 'package:book_quotes/domain/models/users/user_model.dart';
import 'package:book_quotes/domain/models/search_books_result.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:book_quotes/utils/extensions/int_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

const String users = 'users';
const String books = 'books';

enum BookQuery {
  title,
  author,
  quote,
  created,
}

extension on Query<BookModel> {
  Query<BookModel> queryBy(BookQuery query) {
    switch (query) {
      case BookQuery.title:
        return orderBy('title', descending: true);
      case BookQuery.author:
        return orderBy('author', descending: true);
      case BookQuery.quote:
        return orderBy('quote', descending: true);
      case BookQuery.created:
        return orderBy('created', descending: false);
    }
  }
}

final _usersDB = FirebaseFirestore.instance
    .collection(users)
    .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson());

class BookService extends GetxService {
  BookQuery query = BookQuery.title;

  CollectionReference<BookModel> _booksDB({required String uid}) {
    CollectionReference<BookModel> bookCol = _usersDB
        .doc(uid)
        .collection(books)
        .withConverter<BookModel>(
          fromFirestore: (snapshot, _) => BookModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return bookCol;
  }

  Future<void> create({required String uid, required BookModel book}) async {
    try {
      // Create document reference of book.s
      final DocumentReference bookDocRef = _booksDB(uid: uid).doc();

      // Update ID of the book.
      book = book.copyWith(id: bookDocRef.id);

      // Set book data.
      return bookDocRef.set(book);
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<int> getTotalBookCount({required String uid}) async {
    try {
      AggregateQuery count = _usersDB.doc(uid).collection(books).count();
      return (await count.get()).count;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // https://stackoverflow.com/questions/46798981/firestore-how-to-get-random-documents-in-a-collection
  Future<BookModel> getRandom({required String uid}) async {
    try {
      // Create a random string to use as the index.
      String randomString = 20.getRandomString();

      // Create a base query for books that are not hidden.
      Query<BookModel> query = (_booksDB(uid: uid)
          .where('hidden', isEqualTo: false)
          .orderBy('id')
          .limit(1));

      // Check for books with a greater index than random, (results maybe).
      List<QueryDocumentSnapshot<BookModel>> firstRoundDocs =
          (await query.where('id', isGreaterThanOrEqualTo: randomString).get())
              .docs;

      if (firstRoundDocs.isNotEmpty) {
        return firstRoundDocs[0].data();
      }

      // Check for books with a greater index than the empty string, (results guaranteed).
      List<QueryDocumentSnapshot<BookModel>> secondRoundDocs =
          (await query.where('id', isGreaterThanOrEqualTo: '').get()).docs;

      if (secondRoundDocs.isNotEmpty) {
        return secondRoundDocs[0].data();
      }

      throw Exception('No random book found.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> update({
    required String uid,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      data['modified'] = DateTime.now().toUtc();
      await _booksDB(uid: uid).doc(id).update(data);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<void> delete({
    required String uid,
    required String id,
  }) async {
    try {
      await _booksDB(uid: uid).doc(id).delete();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<List<BookModel>> list({
    required String uid,
    int? limit,
    String? orderBy,
  }) async {
    try {
      CollectionReference<BookModel> bookCol = FirebaseFirestore.instance
          .collection(users)
          .doc(uid)
          .collection('books')
          .withConverter<BookModel>(
              fromFirestore: (snapshot, _) =>
                  BookModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson());

      Query q = bookCol.queryBy(query);

      if (limit != null) {
        q = q.limit(limit);
      }

      if (orderBy != null) {
        q = q.orderBy(orderBy, descending: true);
      }

      List<BookModel> books = (await q.get())
          .docs
          .map(
            (doc) => doc.data() as BookModel,
          )
          .toList();

      return books;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<List<BookModel>> fetchPage({
    required Timestamp? created,
    required int limit,
    required String uid,
  }) async {
    try {
      CollectionReference<BookModel> bookCol = FirebaseFirestore.instance
          .collection(users)
          .doc(uid)
          .collection('books')
          .withConverter<BookModel>(
              fromFirestore: (snapshot, _) =>
                  BookModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson());

      Query q = bookCol.queryBy(BookQuery.created);

      q = q.limit(limit);

      if (created != null) {
        q = q.startAfter([created]);
      }

      List<QueryDocumentSnapshot<Object?>> docs = (await q.get()).docs;

      List<BookModel> books = docs
          .map(
            (doc) => doc.data() as BookModel,
          )
          .toList();

      return books;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  /// Search for books by search term.
  Future<SearchBooksResult> search({required String term}) async {
    // Request URL.
    final String baseUrl =
        'https://www.googleapis.com/books/v1/volumes?q=$term&key=${Globals.googleBooksAPIKey}';

    // Send http request.
    final response = await http.get(Uri.parse(baseUrl));

    // Convert body to json.
    final results = json.decode(response.body);

    if (results['Response'] == 'False') {
      throw Exception(results['Error']);
    } else {
      return SearchBooksResult.fromJson(results);
    }
  }
}
