part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    UserCredential? userCredential,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [isLoading, isSuccess, errorMessage];
}
