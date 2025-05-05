import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/components/firebase_api/firebase_api.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseApi _firebaseApi;
  LoginBloc({required FirebaseApi firebaseApi})
    : _firebaseApi = firebaseApi,
      super(LoginState()) {
    on<LoginWithEmailEvent>(_onLoginWithEmail);
    on<ClearErrorMessageEvent>(
      (event, emit) => emit(state.copyWith(errorMessage: '')),
    );
  }

  Future<void> _onLoginWithEmail(
    LoginWithEmailEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Email and password cannot be empty',
          ),
        );
        return;
      }
      await _firebaseApi.login(email: event.email, password: event.password);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on Exception catch (e) {
      log(e.toString(), name: 'LoginBloc - onLoginWithEmail');
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
