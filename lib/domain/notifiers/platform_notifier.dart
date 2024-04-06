import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PlatformType {
  isAndroid,
  isIOS,
  isWeb,
}

class PlatformNotifier extends AutoDisposeNotifier<PlatformType> {
  @override
  PlatformType build() {
    if (kIsWeb) {
      return PlatformType.isWeb;
    } else if (!kIsWeb && Platform.isIOS) {
      return PlatformType.isIOS;
    } else if (!kIsWeb && Platform.isAndroid) {
      return PlatformType.isAndroid;
    } else {
      throw Exception('Platform is being used on an unknown device.');
    }
  }
}
