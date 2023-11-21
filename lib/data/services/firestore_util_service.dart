import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreUtilService extends GetxService {
  Future<void> addPropertyToDocuments({
    required String collection,
    required String key,
    required dynamic value,
  }) async {
    var query = await FirebaseFirestore.instance.collection(collection).get();

    final batch = FirebaseFirestore.instance.batch();

    for (var doc in query.docs) {
      batch.update(doc.reference, {key: value});
    }

    await batch.commit();

    debugPrint('${query.docs.length}');
  }
}
