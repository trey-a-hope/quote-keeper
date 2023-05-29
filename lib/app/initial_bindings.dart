import 'package:book_quotes/services/book_service.dart';
import 'package:book_quotes/services/fcm_service.dart';
import 'package:book_quotes/services/modal_service.dart';
import 'package:book_quotes/services/storage_service.dart';
import 'package:book_quotes/services/user_service.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookService());
    Get.lazyPut(() => FCMService());
    Get.lazyPut(() => ModalService(), fenix: true);
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => UserService());
  }
}
