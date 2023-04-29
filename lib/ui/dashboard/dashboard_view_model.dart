import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardViewModel extends GetxController {
  final GetStorage _getStorage = GetStorage();

  @override
  void onInit() async {
    super.onInit();

    await _load();
  }

  Future _load() async {
    try {
      update();
    } catch (e) {
      debugPrint('');
    }
  }
}
