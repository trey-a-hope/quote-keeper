import 'package:book_quotes/services/fcm_service.dart';
import 'package:book_quotes/services/model_service.dart';
import 'package:book_quotes/services/quote_service.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FCMService());
    Get.lazyPut(() => QuoteService());
    Get.lazyPut(() => ModalService(), fenix: true);
  }
}
