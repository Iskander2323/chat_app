part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainInitialEvent extends MainEvent {}

class ClearErrorMessageEvent extends MainEvent {}
