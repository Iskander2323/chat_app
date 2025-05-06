import 'package:chat_app/app.dart';
import 'package:chat_app/components/firebase_api/firebase_auth_api.dart';
import 'package:chat_app/components/firebase_api/firebase_chat_api.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuthApi firebaseApi = FirebaseAuthApi();
  final FirebaseChatApi firebaseChatApi = FirebaseChatApi();

  runApp(App(firebaseApi: firebaseApi, firebaseChatApi: firebaseChatApi));
}
