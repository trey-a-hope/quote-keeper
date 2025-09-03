import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> share({
    required String text,
    required String subject,
  }) async =>
      SharePlus.instance.share(
        ShareParams(text: text, subject: subject),
      );
}
