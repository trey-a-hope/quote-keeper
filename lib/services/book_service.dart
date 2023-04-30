import 'dart:math';

import 'package:book_quotes/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookService extends GetxService {
  /// Users collection reference.
  final CollectionReference _booksDB =
      FirebaseFirestore.instance.collection('BookQuotes');

  final CollectionReference _booksIdsDB =
      FirebaseFirestore.instance.collection('BookQuotesIds');

  /// Create a user.
  Future<void> create({required BookModel book}) async {
    try {
      // Create batch instance.
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      // Create document reference of user.
      final DocumentReference userDocRef = _booksDB.doc();

      _booksIdsDB.doc('books').update(
        {
          'ids': FieldValue.arrayUnion(
            [
              userDocRef.id,
            ],
          )
        },
      );

      book = book.copyWith(id: userDocRef.id);

      // Set the user data to the document reference.
      batch.set(
        userDocRef,
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
      final DocumentReference model = _booksDB.doc(id).withConverter<BookModel>(
          fromFirestore: (snapshot, _) => BookModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

      return (await model.get()).data() as BookModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<BookModel?> getRandom() async {
    try {
      final DocumentReference model = _booksIdsDB
          .doc('books')
          .withConverter<dynamic>(
              fromFirestore: (snapshot, _) => snapshot.data()!,
              toFirestore: (model, _) => model);

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
      Query query = _booksDB;

      if (limit != null) {
        query = query.limit(limit);
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: true);
      }

      List<Future<DocumentSnapshot<BookModel>>> s = (await query.get())
          .docs
          .map((doc) => (doc.reference
              .withConverter<BookModel>(
                  fromFirestore: (snapshot, _) =>
                      BookModel.fromJson(snapshot.data()!),
                  toFirestore: (model, _) => model.toJson())
              .get()))
          .toList();

      List<BookModel> books = [];

      for (int i = 0; i < s.length; i++) {
        DocumentSnapshot<BookModel> res = await s[i];
        books.add(res.data()!);
      }

      return books;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
