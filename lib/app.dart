import 'package:chat_app/components/firebase_api/firebase_auth_api.dart';
import 'package:chat_app/components/firebase_api/firebase_chat_api.dart';
import 'package:chat_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.firebaseApi,
    required this.firebaseChatApi,
  });

  final FirebaseAuthApi firebaseApi;
  final FirebaseChatApi firebaseChatApi;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuthApi>(create: (context) => firebaseApi),
        RepositoryProvider(create: (context) => firebaseChatApi),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
      ),
    );
  }
}
