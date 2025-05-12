import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/components/firebase_api/firebase_auth_api.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuthApi _firebaseApi;
  RegisterBloc({required FirebaseAuthApi firebaseApi})
    : _firebaseApi = firebaseApi,
      super(RegisterState()) {
    on<RegisterNewAccountEvent>(_registerAccount);
    on<ClearErrorMessageEvent>((event, emit) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  Future<void> _registerAccount(
    RegisterNewAccountEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      if (event.password == event.confirmPassword) {
        await _firebaseApi.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        emit(state.copyWith(isSuccess: true, isLoading: false));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Passwords do not match',
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'RegisterBloc - registerAccount');
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
