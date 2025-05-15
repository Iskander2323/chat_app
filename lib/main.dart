import 'dart:developer';

import 'package:chat_app/app.dart';
import 'package:chat_app/components/firebase_api/firebase_auth_api.dart';
import 'package:chat_app/components/firebase_api/firebase_chat_api.dart';
import 'package:chat_app/components/firebase_api/firebase_notification_messaging_api.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Title: ${message.notification?.title}');
  log('body: ${message.notification?.body}');
  log('data: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseAuthApi firebaseApi = FirebaseAuthApi();
  final FirebaseChatApi firebaseChatApi = FirebaseChatApi();
  await FirebaseNotificationMessagingAPI().initialize();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  runApp(App(firebaseApi: firebaseApi, firebaseChatApi: firebaseChatApi));
}
