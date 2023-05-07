import 'dart:math';

import 'package:book_quotes/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum BookQuery { title, author }

extension on Query<BookModel> {
  Query<BookModel> queryBy(BookQuery query) {
    switch (query) {
      case BookQuery.title:
        return orderBy('title', descending: true);
      case BookQuery.author:
        return orderBy('author', descending: true);
    }
  }
}

// Books Collection
final _booksDB = FirebaseFirestore.instance
    .collection('BookQuotes')
    .withConverter<BookModel>(
        fromFirestore: (snapshot, _) => BookModel.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson());

// Book IDs Collection
final CollectionReference _booksIdsDB = FirebaseFirestore.instance
    .collection('BookQuotesIds')
    .withConverter<dynamic>(
        fromFirestore: (snapshot, _) => snapshot.data()!,
        toFirestore: (model, _) => model);

class BookService extends GetxService {
  BookQuery query = BookQuery.title;

  /// Create a user.
  Future<void> create({required BookModel book}) async {
    try {
      // Create batch instance.
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      // Create document reference of user.
      final DocumentReference bookDocRef = _booksDB.doc();

      _booksIdsDB.doc('books').update(
        {
          'ids': FieldValue.arrayUnion(
            [
              bookDocRef.id,
            ],
          )
        },
      );

      book = book.copyWith(id: bookDocRef.id);

      // Set the user data to the document reference.
      batch.set(
        bookDocRef,
        book.toJson(),
      );
      // Execute batch.
      await batch.commit();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  /// Retrieve a user.
  Future<BookModel?> _get({required String id}) async {
    try {
      final DocumentReference model = _booksDB.doc(id);
      return (await model.get()).data() as BookModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getTotalBookCount() async {
    try {
      final DocumentReference model = _booksIdsDB.doc('books');
      Map map = (await model.get()).data() as Map;
      List<dynamic> ids = map['ids'];
      return ids.length;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<BookModel?> getRandom() async {
    try {
      final DocumentReference model = _booksIdsDB.doc('books');

      Map map = (await model.get()).data() as Map;
      List<dynamic> ids = map['ids'];

      Random random = Random();
      int index = random.nextInt(ids.length);

      String id = ids[index];

      BookModel? book = await _get(id: id);

      return book;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Update a user.
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

  /// Retrieve users.
  Future<List<BookModel>> list({int? limit, String? orderBy}) async {
    try {
      Query q = _booksDB.queryBy(query);

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
}
