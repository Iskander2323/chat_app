part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({
    this.isLoading = false,
    this.errorMessage = '',
    this.userList = const <UserModel>[],
  });

  MainState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<UserModel>? userList,
  }) {
    return MainState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userList: userList ?? this.userList,
    );
  }

  final bool isLoading;
  final String errorMessage;
  final List<UserModel> userList;

  @override
  List<Object> get props => [isLoading, errorMessage, userList];
}
