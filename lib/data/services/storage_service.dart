import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
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

  Future<void> deleteFile({required String path}) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref().child(path);
      await ref.delete();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
