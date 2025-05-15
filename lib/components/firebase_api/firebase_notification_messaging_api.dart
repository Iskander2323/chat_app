import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationMessagingAPI {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();
    log('FCM Token: $token');
  }

  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      log('FCM Token: $token');
      return token;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }
}
