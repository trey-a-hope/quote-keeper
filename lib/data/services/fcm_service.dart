import 'dart:async';
import 'dart:convert' show json;
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String _endpoint = 'https://fcm.googleapis.com/fcm/send';
  final String _contentType = 'application/json';
  final String _authorization =
      'key=${Globals.googleAPIKeys.cloudMessagingServerKey}';

  Future<http.Response> _sendNotification(
    String to,
    String title,
    String body,
  ) async {
    try {
      String message = '';
      String userID = '';
      String type = '';

      final dynamic data = json.encode(
        {
          'to': to,
          'priority': 'high',
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            'message': message,
            'userID': userID,
            'type': type,
          },
          'content_available': true
        },
      );
      http.Response response = await http.post(
        Uri.parse(_endpoint),
        body: data,
        headers: {
          'Content-Type': _contentType,
          'Authorization': _authorization
        },
      );

      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> unsubscribeFromTopic({required String topic}) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> subscribeToTopic({required String topic}) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> sendNotificationToUser({
    required String fcmToken,
    required String title,
    required String body,
  }) {
    return _sendNotification(
      fcmToken,
      title,
      body,
    );
  }

  Future<void> sendNotificationToGroup(
      {required String group, required String title, required String body}) {
    return _sendNotification('/topics/$group', title, body);
  }
}
