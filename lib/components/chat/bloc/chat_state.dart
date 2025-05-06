part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  ChatState copyWith({bool? isLoading, bool? isSuccess, String? errorMessage}) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [isLoading, isSuccess, errorMessage];
}
