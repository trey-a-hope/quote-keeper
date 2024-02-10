import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:quote_keeper/data/services/storage_service.dart';
import 'package:quote_keeper/domain/models/feedback_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class FeedbackService {
  final _storageService = StorageService();
  final _feedbacksDB = FirebaseFirestore.instance.collection('feedbacks');

  /// Creates a new Feedback document in the Firestore database.
  Future<void> create(UserFeedback ufb, String uid) async {
    try {
      // Create batch instance.
      final batch = FirebaseFirestore.instance.batch();

      // Create new document reference.
      final feedbackDocRef = _feedbacksDB.doc();

      // Get id of new document.
      final id = feedbackDocRef.id;

      // Specify path for the screenshot in storage.
      final path = 'Images/Feedbacks/$id';

      // Write screenshot to storage.
      final screenshotFilePath = await _writeImageToStorage(ufb.screenshot);

      // Get file from path.
      final file = File(screenshotFilePath);

      // Upload file to storage.
      await _storageService.uploadFile(file: file, path: path);

      // Create feedback model.
      final feedback = FeedbackModel(
        id: id,
        created: DateTime.now(),
        text: ufb.text,
        screenshot: screenshotFilePath,
        uid: uid,
      );

      // Set feedback document.
      batch.set(
        feedbackDocRef,
        feedback.toJson(),
      );

      // Execute batch.
      await batch.commit();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<String> _writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
}
