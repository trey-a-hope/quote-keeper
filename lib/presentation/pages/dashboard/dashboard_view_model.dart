import 'package:quote_keeper/data/services/firestore_util_service.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/data/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class DashboardViewModel extends GetxController {
  final BookService _bookService = Get.find();
  final FirestoreUtilService _firestoreUtilService = Get.find();
  final GetStorage _getStorage = Get.find();

  BookModel? _book;
  BookModel? get book => _book;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _showTutorial = false;
  bool get showTutorial => _showTutorial;

  @override
  void onInit() async {
    super.onInit();
    await load();
  }

  Future load() async {
    try {
      var exists = await _bookService.booksCollectionExists(
        uid: _getStorage.read('uid'),
      );

      if (exists) {
        _book = await _bookService.getRandom(
          uid: _getStorage.read('uid'),
        );
      }

      _showTutorial = !_getStorage.read(Globals.tutorialComplete);

      _isLoading = false;

      // await _firestoreUtilService.addPropertyToDocuments(
      //   collection: 'users',
      //   key: 'tutorialComplete',
      //   value: false,
      // );

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateBook({required BookModel newBook}) {
    _book = newBook;
    update();
  }
}
