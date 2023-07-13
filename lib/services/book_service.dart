import 'package:book_quotes/models/books/book_model.dart';
import 'package:book_quotes/models/users/user_model.dart';
import 'package:book_quotes/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

const String users = 'users';
const String books = 'books';

enum BookQuery {
  title,
  author,
  quote,
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
      String randomString = 20.getRandomString();

      Query<BookModel> query = (_booksDB(uid: uid)
          .where('hidden', isEqualTo: false)
          .orderBy('id')
          .limit(1));

      List<QueryDocumentSnapshot<BookModel>> firstRoundDocs =
          (await query.where('id', isGreaterThanOrEqualTo: randomString).get())
              .docs;

      if (firstRoundDocs.isNotEmpty) {
        return firstRoundDocs[0].data();
      }

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
}
