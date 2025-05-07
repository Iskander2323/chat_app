import 'package:chat_app/components/chat/bloc/chat_bloc.dart';
import 'package:chat_app/components/chat/ui/chat_page_body.dart';
import 'package:chat_app/components/firebase_api/firebase_chat_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.userEmail, required this.userId});

  final String userEmail;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ChatBloc(
            firebaseChatApi: context.read<FirebaseChatApi>(),
            userId: userId,
            userEmail: userEmail,
          )..add(ChatInitialEvent()),
      child: ChatPageBody(userEmail: userEmail, userId: userId),
    );
  }
}
