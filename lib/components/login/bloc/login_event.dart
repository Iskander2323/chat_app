part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailEvent extends LoginEvent {
  const LoginWithEmailEvent({required this.email, required this.password});

  final String email;
  final String password;
}

class ClearErrorMessageEvent extends LoginEvent {}
