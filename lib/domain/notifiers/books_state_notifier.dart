import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/data/services/firestore_book_service.dart';

// Paginated list of books for a user.
class BooksStateNotifier extends StateNotifier<List<BookModel>> {
  final GetStorage _getStorage = Get.find();
  final FirestoreBookService _firestoreBookService = Get.find();

  late String _uid;
  late DocumentSnapshot _lastDocument;

  BooksStateNotifier() : super([]) {
    _uid = _getStorage.read('uid');
  }

  Future<List<BookModel>> getInitialBooks() async {
    try {
      final data = await _firestoreBookService.getBooks(
        uid: _uid,
      );
      _lastDocument = data.docs.last;
      List<BookModel> books = _convertDataToBooks(data);
      state = books;
    } catch (e) {
      rethrow;
    }
    return state;
  }

  void getNextBooks() async {
    try {
      final data = await _firestoreBookService.getBooks(
        uid: _uid,
        lastDocument: _lastDocument,
      );
      _lastDocument = data.docs.last;
      List<BookModel> books = _convertDataToBooks(data);
      state = [...state, ...books];
    } catch (e) {
      if (e is StateError) {
      } else {
        rethrow;
      }
    }
  }

  // Converts a querysnapshot into an array of books.
  List<BookModel> _convertDataToBooks(QuerySnapshot<Object?> o) => o.docs
      .map(
        (doc) => doc.data() as BookModel,
      )
      .toList();
}
