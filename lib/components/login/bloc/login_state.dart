part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  @override
  List<Object> get props => [isLoading, isSuccess, errorMessage];
  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
