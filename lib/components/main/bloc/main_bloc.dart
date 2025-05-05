import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/components/data/model/user_model.dart';
import 'package:chat_app/components/firebase_api/firebase_api.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final FirebaseApi _firebaseApi;
  MainBloc({required FirebaseApi firebaseApi})
    : _firebaseApi = firebaseApi,
      super(MainState()) {
    on<MainInitialEvent>(_onMainInitialEvent);
    on<ClearErrorMessageEvent>(
      (event, emit) => emit(state.copyWith(errorMessage: '')),
    );
  }

  Future<void> _onMainInitialEvent(
    MainInitialEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final userList = await _firebaseApi.getUsers();
      userList.removeWhere(
        (user) => user.id == _firebaseApi.getCurrentUser()?.uid,
      );
      emit(state.copyWith(isLoading: false, userList: userList));
    } catch (e) {
      log(e.toString(), name: 'MainBloc - onMainInitialEvent');
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
