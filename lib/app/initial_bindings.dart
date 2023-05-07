import 'package:book_quotes/data/services/book_service.dart';
import 'package:book_quotes/data/services/fcm_service.dart';
import 'package:book_quotes/data/services/modal_service.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FCMService());
    Get.lazyPut(() => BookService());
    Get.lazyPut(() => ModalService(), fenix: true);
  }
}
