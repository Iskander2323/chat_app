part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterNewAccountEvent extends RegisterEvent {
  const RegisterNewAccountEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
}

class ClearErrorMessageEvent extends RegisterEvent {}
