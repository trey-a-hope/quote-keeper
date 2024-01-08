import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';

final _firestore = FirebaseFirestore.instance;

final _booksDB = _firestore
    .collection('books')
    .orderBy('created', descending: false)
    .withConverter<BookModel>(
        fromFirestore: (snapshot, _) => BookModel.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson());

class FirestoreBookService extends GetxService {
  Future<int> getTotalBookCount({required String uid}) async {
    Query<BookModel> query = _booksDB.where(
      'uid',
      isEqualTo: uid,
    );
    AggregateQuery count = query.count();
    AggregateQuerySnapshot snapshot = await count.get();
    return snapshot.count;
  }

  Future<QuerySnapshot<Object?>> getBooks({
    required String uid,
    DocumentSnapshot? lastDocument,
  }) async {
    final booksColRef = _booksDB.where(
      'uid',
      isEqualTo: uid,
    );

    Query booksQuery = booksColRef.limit(10);

    if (lastDocument != null) {
      booksQuery = booksQuery.startAfterDocument(lastDocument);
    }

    final QuerySnapshot querySnapshot = await booksQuery.get();
    return querySnapshot;
  }
}
