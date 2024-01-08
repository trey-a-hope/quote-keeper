import 'package:quote_keeper/data/services/book_service.dart';
import 'package:quote_keeper/data/services/fcm_service.dart';
import 'package:quote_keeper/data/services/firestore_book_service.dart';
import 'package:quote_keeper/data/services/firestore_util_service.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:quote_keeper/data/services/share_service.dart';
import 'package:quote_keeper/data/services/storage_service.dart';
import 'package:quote_keeper/data/services/tutorial_service.dart';
import 'package:quote_keeper/data/services/user_service.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookService());
    Get.lazyPut(() => FirestoreBookService());
    Get.lazyPut(() => FCMService());
    Get.lazyPut(() => FirestoreUtilService());
    Get.lazyPut(() => ModalService(), fenix: true);
    Get.lazyPut(() => ShareService());
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => TutorialService());
    Get.lazyPut(() => UserService());
  }
}
