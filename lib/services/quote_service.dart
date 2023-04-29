import 'package:book_quotes/models/quote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuoteService extends GetxService {
  /// Users collection reference.
  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('BookQuotes');

  /// Create a user.
  Future<void> createQuote({required QuoteModel quote}) async {
    try {
      // Create batch instance.
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      // Create document reference of user.
      final DocumentReference userDocRef = _usersDB.doc();

      quote = quote.copyWith(id: userDocRef.id);

      // Set the user data to the document reference.
      batch.set(
        userDocRef,
        quote.toJson(),
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
  Future<QuoteModel?> retrieveQuote({required String id}) async {
    try {
      final DocumentReference model = _usersDB
          .doc(id)
          .withConverter<QuoteModel>(
              fromFirestore: (snapshot, _) =>
                  QuoteModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson());

      return (await model.get()).data() as QuoteModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Update a user.
  Future<void> updateQuote({
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
  Future<List<QuoteModel>> retrieveQuotes(
      {int? limit,   String? orderBy}) async {
    try {
      Query query = _usersDB;

      if (limit != null) {
        query = query.limit(limit);
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: true);
      }

      List<Future<DocumentSnapshot<QuoteModel>>> s = (await query.get())
          .docs
          .map((doc) => (doc.reference
              .withConverter<QuoteModel>(
                  fromFirestore: (snapshot, _) =>
                      QuoteModel.fromJson(snapshot.data()!),
                  toFirestore: (model, _) => model.toJson())
              .get()))
          .toList();

      List<QuoteModel> users = [];

      for (int i = 0; i < s.length; i++) {
        DocumentSnapshot<QuoteModel> res = await s[i];
        users.add(res.data()!);
      }

      return users;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
