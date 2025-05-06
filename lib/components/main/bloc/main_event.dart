part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainInitialEvent extends MainEvent {}

class ClearErrorMessageEvent extends MainEvent {}

class LogoutEvent extends MainEvent {}

class AddUsersListEvent extends MainEvent {
  const AddUsersListEvent(this.userList);

  final List<UserModel> userList;
}

class AddUsersListErrorEvent extends MainEvent {
  const AddUsersListErrorEvent(this.errorMessage);

  final String errorMessage;
}
