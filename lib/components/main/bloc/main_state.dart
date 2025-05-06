part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({
    this.isLoading = false,
    this.errorMessage = '',
    this.userList = const <UserModel>[],
    this.isSuccess = true,
  });

  MainState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<UserModel>? userList,
    bool? isSuccess,
  }) {
    return MainState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userList: userList ?? this.userList,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final List<UserModel> userList;

  @override
  List<Object> get props => [isLoading, errorMessage, userList, isSuccess];
}
