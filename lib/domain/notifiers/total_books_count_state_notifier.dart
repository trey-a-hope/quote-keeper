import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/book_service.dart';

// Total number of books for a user.
class TotalBooksCountStateNotifier extends StateNotifier<int> {
  final _getStorage = GetStorage();
  final _bookService = BookService();

  late String _uid;

  TotalBooksCountStateNotifier() : super(0) {
    _uid = _getStorage.read('uid');
    _getTotalBookCount();
  }

  void _getTotalBookCount() async =>
      state = await _bookService.getTotalBookCount(uid: _uid);

  void increment() => state++;

  void decrement() => state--;
}
