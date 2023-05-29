import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageService extends GetxService {
  Future<String> uploadFile({
    required File file,
    required String path,
  }) async {
    try {
      final Reference reference = FirebaseStorage.instance.ref().child(path);
      final UploadTask uploadTask = reference.putFile(file);
      final Reference secondReference = (await uploadTask).ref;
      return (await secondReference.getDownloadURL()).toString();
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
