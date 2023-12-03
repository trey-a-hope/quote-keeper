// import 'package:quote_keeper/data/services/firestore_util_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class DashboardViewModel extends GetxController {
  final BookService _bookService = Get.find();
  // final FirestoreUtilService _firestoreUtilService = Get.find();
  final GetStorage _getStorage = Get.find();

  BookModel? _book;
  BookModel? get book => _book;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _showTutorial = false;
  bool get showTutorial => _showTutorial;

  late bool _booksCollectionExists;

  @override
  void onInit() async {
    super.onInit();
    _booksCollectionExists = await _checkIfBooksCollectionExists();
    await load();
  }

  Future<bool> _checkIfBooksCollectionExists() async =>
      await _bookService.booksCollectionExists(
        uid: _getStorage.read('uid'),
      );

  void reload() {
    _booksCollectionExists = true;
    load();
  }

  Future load() async {
    try {
      if (_booksCollectionExists) {
        // Fetch random book.
        _book = await _bookService.getRandom(
          uid: _getStorage.read('uid'),
        );
      }

      // If first time using app, run tutorial.
      _showTutorial = !_getStorage.read(Globals.tutorialComplete);

      // Loading complete.
      _isLoading = false;

      // await _firestoreUtilService.addPropertyToDocuments(
      //   collection: 'users',
      //   key: 'tutorialComplete',
      //   value: false,
      // );

      update();
    } catch (e) {
      debugPrint(e.toString());
      _isLoading = false;
      update();
    }
  }

  void updateBook({required BookModel newBook}) {
    _book = newBook;
    update();
  }
}
