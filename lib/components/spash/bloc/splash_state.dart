part of 'splash_bloc.dart';

class SplashState extends Equatable {
  const SplashState({this.isSuccess = false});

  final bool isSuccess;

  SplashState copyWith({bool? isSuccess}) {
    return SplashState(isSuccess: isSuccess ?? this.isSuccess);
  }

  @override
  List<Object> get props => [isSuccess];
}
