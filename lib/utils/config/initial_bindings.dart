import 'package:book_quotes/data/services/book_service.dart';
import 'package:book_quotes/data/services/fcm_service.dart';
import 'package:book_quotes/data/services/modal_service.dart';
import 'package:book_quotes/data/services/share_service.dart';
import 'package:book_quotes/data/services/storage_service.dart';
import 'package:book_quotes/data/services/user_service.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookService());
    Get.lazyPut(() => FCMService());
    Get.lazyPut(() => ModalService(), fenix: true);
    Get.lazyPut(() => ShareService());
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => UserService());
  }
}
