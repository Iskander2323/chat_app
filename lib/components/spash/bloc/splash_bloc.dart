import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<InitialEvent>((event, emit) {
      emit(state.copyWith(isSuccess: true));
    });
  }
}
