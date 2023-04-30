import 'package:book_quotes/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookService extends GetxService {
  /// Users collection reference.
  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('BookQuotes');

  /// Create a user.
  Future<void> create({required BookModel book}) async {
    try {
      // Create batch instance.
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      // Create document reference of user.
      final DocumentReference userDocRef = _usersDB.doc();

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
  Future<BookModel?> get({required String id}) async {
    try {
      final DocumentReference model = _usersDB.doc(id).withConverter<BookModel>(
          fromFirestore: (snapshot, _) => BookModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

      return (await model.get()).data() as BookModel;
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
      await _usersDB.doc(id).update(data);
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
      Query query = _usersDB;

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
