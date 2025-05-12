import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/components/data/model/show_message.dart';
import 'package:chat_app/components/firebase_api/firebase_chat_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseChatApi _firebaseChatApi;
  final String userId;
  final String userEmail;
  StreamSubscription<QuerySnapshot>? _messagesSubscription;
  ChatBloc({
    required FirebaseChatApi firebaseChatApi,
    required this.userId,
    required this.userEmail,
  }) : _firebaseChatApi = firebaseChatApi,
       super(ChatState()) {
    on<ChatInitialEvent>(_initialEvent);
    on<LoadMessagesEvent>(_loadMessagesEvent);
    on<ErrorEvent>(_errorEvent);
    on<SendMessageEvent>(_sendMessageEvent);
  }

  Future<void> _sendMessageEvent(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _firebaseChatApi.sendMessage(
        message: event.message,
        receiverId: userId,
      );
    } on Exception catch (e) {
      log(e.toString(), name: 'ChatBloc - _sendMessageEvent');
    }
  }

  void _errorEvent(ErrorEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(errorMessage: event.errorMessage));
  }

  void _loadMessagesEvent(LoadMessagesEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(messagesList: event.messagesList));
  }

  Future<void> _initialEvent(
    ChatInitialEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(currentUserId: _firebaseChatApi.currentUserId));
    _messagesSubscription?.cancel();
    _messagesSubscription = _firebaseChatApi
        .getMessages(userId)
        .listen(
          (doc) {
            final messagesList =
                doc.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>?;
                  return ShowMessage(
                    message: data?['message'],
                    timestamp: data?['timestamp'],
                    senderId: data?['senderId'],
                  );
                }).toList();

            add(LoadMessagesEvent(messagesList: messagesList));
          },
          onError: (error) {
            add(ErrorEvent(errorMessage: error));
          },
          onDone: () {},
        );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
