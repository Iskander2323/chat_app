import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class FirebaseNotificationMessagingAPI {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    // Foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      _handleNavigation(message, navigatorKey);
    });

    // Background - user tapped
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNavigation(message, navigatorKey);
    });

    // Terminated
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNavigation(initialMessage, navigatorKey);
    }

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

  void _handleNavigation(
    RemoteMessage message,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    final data = message.data;
    final String? userId = data['user_id'];
    final String? userEmail = data['user_email'];
    final String? userName = data['user_name'];

    if (userId != null && userEmail != null && userName != null) {
      navigatorKey.currentState?.context.pushNamed(
        'splash_page/main_page/chat_page',
        extra: {
          'user_id': userId,
          'user_email': userEmail,
          'user_name': userName,
        },
      );
    }
  }
}
