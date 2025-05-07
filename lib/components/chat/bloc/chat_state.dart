part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.errorMessage = '',
    this.messagesList = const [],
    this.currentUserId = '',
  });

  final String errorMessage;
  final List<ShowMessage> messagesList;
  final String currentUserId;

  ChatState copyWith({
    String? currentUserId,
    String? errorMessage,
    List<ShowMessage>? messagesList,
  }) {
    return ChatState(
      currentUserId: currentUserId ?? this.currentUserId,
      errorMessage: errorMessage ?? this.errorMessage,
      messagesList: messagesList ?? this.messagesList,
    );
  }

  @override
  List<Object> get props => [currentUserId, errorMessage, messagesList];
}
