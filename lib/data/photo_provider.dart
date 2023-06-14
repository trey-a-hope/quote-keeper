import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotoProvider extends ChangeNotifier {
  CroppedFile? selectedCroppedFile;

  PhotoProvider();

  Future updateImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (file == null) return;

      CroppedFile? croppedFile =
          await ImageCropper().cropImage(sourcePath: file.path);

      if (croppedFile == null) return;

      selectedCroppedFile = croppedFile;

      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
