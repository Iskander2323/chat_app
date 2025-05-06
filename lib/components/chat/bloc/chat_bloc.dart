import 'package:bloc/bloc.dart';
import 'package:chat_app/components/firebase_api/firebase_chat_api.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseChatApi _firebaseChatApi;
  ChatBloc({required FirebaseChatApi firebaseChatApi})
    : _firebaseChatApi = firebaseChatApi,
      super(ChatState()) {
    on<ChatInitialEvent>(_initialEvent);
  }

  Future<void> _initialEvent(
    ChatInitialEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
  }
}
