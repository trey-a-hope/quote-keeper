import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quote_keeper/domain/models/book_model.dart';
import 'package:quote_keeper/domain/models/search_books_result.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:quote_keeper/utils/extensions/int_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class BookService {
  static final _firestore = FirebaseFirestore.instance;

  static final _booksDB = _firestore
      .collection('books')
      .withConverter<BookModel>(
          fromFirestore: (snapshot, _) => BookModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  Future<QuerySnapshot<Object?>> getBooks({
    required String uid,
    required String orderBy,
    required bool descending,
    int limit = 5,
    DocumentSnapshot? lastDocument,
  }) async {
    var booksQuery = _booksDB
        .orderBy(
          orderBy,
          descending: descending,
        )
        .where(
          'uid',
          isEqualTo: uid,
        )
        .limit(limit);

    if (lastDocument != null) {
      booksQuery = booksQuery.startAfterDocument(lastDocument);
    }

    final QuerySnapshot querySnapshot = await booksQuery.get();

    return querySnapshot;
  }

  // Return true if a user already has books in their collection.
  Future<bool> booksCollectionExists({required String uid}) async =>
      (await _booksDB.where('uid', isEqualTo: uid).get()).docs.isNotEmpty;

  Future<String> create(BookModel book) async {
    try {
      // Create document reference of book.s
      final DocumentReference bookDocRef = _booksDB.doc();

      // Update ID of the book.
      book = book.copyWith(id: bookDocRef.id);

      // Set book data.
      bookDocRef.set(book);

      return book.id!;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  // Return total amount of books for a user.
  Future<int> getTotalBookCount({
    required String uid,
    DateTime? rangeStart,
    DateTime? rangeEnd,
  }) async {
    Query<BookModel> query = _booksDB.where('uid', isEqualTo: uid);

    if (rangeStart != null && rangeEnd != null) {
      query = query
          .where('created', isGreaterThanOrEqualTo: rangeStart)
          .where('created', isLessThanOrEqualTo: rangeEnd);
    }

    AggregateQuery count = query.count();
    AggregateQuerySnapshot snapshot = await count.get();
    return snapshot.count ?? 0;
  }

  // https://stackoverflow.com/questions/46798981/firestore-how-to-get-random-documents-in-a-collection
  Future<BookModel> getRandom({required String uid}) async {
    try {
      // Create a random string to use as the index.
      String randomString = 20.getRandomString();

      // Create a base query for books that are not hidden.
      Query<BookModel> query = (_booksDB
          .where('uid', isEqualTo: uid)
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
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      data['modified'] = DateTime.now().toUtc();
      await _booksDB.doc(id).update(data);

      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<BookModel> get({
    required String bookId,
  }) async {
    try {
      var bookDoc = await _booksDB.doc(bookId).get();
      return bookDoc.data()!;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<BookModel> getOldestQuote({
    required String uid,
  }) async {
    try {
      Query<BookModel> query = _booksDB
          .where('uid', isEqualTo: uid)
          .orderBy('created', descending: false)
          .limit(1);

      var bookDoc = await query.get();

      return bookDoc.docs.first.data();
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<List<BookModel>> getNewestQuotes({
    required String uid,
    required int limit,
  }) async {
    try {
      Query<BookModel> query = _booksDB
          .where('uid', isEqualTo: uid)
          .orderBy('created', descending: true)
          .limit(limit);

      final querySnapshot = await query.get();

      final books = querySnapshot.docs.map((e) => e.data()).toList();

      return books;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<void> delete({
    required String id,
  }) async {
    try {
      await _booksDB.doc(id).delete();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  /// Search for books by search term.
  Future<SearchBooksResult> searchGoogleBooks({
    required String term,
    required int limit,
  }) async {
    // Request URL.
    final String baseUrl =
        'https://www.googleapis.com/books/v1/volumes?q=$term&maxResults=$limit&key=${Globals.googleAPIKeys.booksAPIKey}';
    try {
      // Send http request.
      final response = await http.get(Uri.parse(baseUrl));

      // Convert body to json.
      final results = json.decode(response.body);

      if (results['error'] != null) {
        throw Exception(results['error']['message']);
      }

      return SearchBooksResult.fromJson(results);
    } catch (e) {
      rethrow;
    }
  }

  // Delete all books that a user posted, as well as the user themselves.
  Future<void> deleteUserAndBooks({required String uid}) async {
    try {
      final querySnapshot = await _firestore
          .collection('books')
          .where('uid', isEqualTo: uid)
          .get();

      final batch = _firestore.batch();

      // Add firestore user to batch.
      var userDocRef = _firestore.collection('users').doc(uid);
      batch.delete(userDocRef);

      // Add book posts to batch.
      for (var doc in querySnapshot.docs) {
        var docRef = _firestore.collection('books').doc(doc.id);
        batch.delete(docRef);
      }

      await batch.commit();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
