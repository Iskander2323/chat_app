part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatInitialEvent extends ChatEvent {}

class LoadMessagesEvent extends ChatEvent {
  const LoadMessagesEvent({required this.messagesList});
  final List<ShowMessage> messagesList;
}

class ErrorEvent extends ChatEvent {
  const ErrorEvent({required this.errorMessage});
  final dynamic errorMessage;
}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent({required this.message});
  final String message;
}
