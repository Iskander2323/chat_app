import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/components/data/model/user_model.dart';
import 'package:chat_app/components/firebase_api/firebase_auth_api.dart';
import 'package:chat_app/components/firebase_api/firebase_chat_api.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final FirebaseAuthApi _firebaseApi;
  final FirebaseChatApi _firebaseChatApi;
  StreamSubscription<List<UserModel>>? _userSubscription;
  MainBloc({
    required FirebaseAuthApi firebaseApi,
    required FirebaseChatApi firebaseChatApi,
  }) : _firebaseApi = firebaseApi,
       _firebaseChatApi = firebaseChatApi,
       super(MainState()) {
    on<MainInitialEvent>(_onMainInitialEvent);
    on<LogoutEvent>(_logoutEvent);
    on<AddUsersListEvent>((event, emit) {
      emit(state.copyWith(isLoading: false, userList: event.userList));
    });
    on<AddUsersListErrorEvent>((event, emit) {
      emit(state.copyWith(isLoading: false, errorMessage: event.errorMessage));
    });
    on<ClearErrorMessageEvent>(
      (event, emit) => emit(state.copyWith(errorMessage: '')),
    );
  }

  Future<void> _logoutEvent(LogoutEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _firebaseApi.logout();
      emit(state.copyWith(isLoading: false, isSuccess: false));
    } on Exception catch (e) {
      log(e.toString(), name: 'MainBloc - logoutEvent');
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onMainInitialEvent(
    MainInitialEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    _userSubscription?.cancel();
    _userSubscription = _firebaseChatApi.getUsers().listen(
      (userList) {
        final filtered =
            userList
                .where((user) => user.id != _firebaseApi.getCurrentUser()?.uid)
                .where((user) => user.id.isNotEmpty)
                .toList();

        add(AddUsersListEvent(filtered));
      },
      onError: (error) {
        log(error.toString(), name: 'MainBloc - getUsers');
        add(AddUsersListErrorEvent(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
