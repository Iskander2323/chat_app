import 'package:bloc/bloc.dart';
import 'package:chat_app/components/firebase_api/firebase_auth_api.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final FirebaseAuthApi _firebaseApi;
  SplashBloc({required FirebaseAuthApi firebaseApi})
    : _firebaseApi = firebaseApi,
      super(SplashState()) {
    on<InitialEvent>((event, emit) {
      final user = _firebaseApi.getCurrentUser();
      if (user == null) {
        emit(state.copyWith(isSuccess: false));
        return;
      }
      emit(state.copyWith(isSuccess: true));
    });
  }
}
