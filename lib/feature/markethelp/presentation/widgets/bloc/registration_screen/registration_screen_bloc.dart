import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registration_screen_event.dart';
part 'registration_screen_state.dart';

class RegistrationScreenBloc
    extends Bloc<RegistrationScreenEvent, RegistrationScreenState> {
  RegistrationScreenBloc() : super(RegistrationScreenInitialState()) {
    on<RegistrationScreenCheckEvent>((event, emit) async {
      // Simulate a network call
      await Future.delayed(Duration(seconds: 2));

      if (event.login.isEmpty || event.password.isEmpty) {
        emit(RegistrationScreenBadCreditalsState());
      } else {
        emit(RegistrationScreenSuccessState());
      }
    });

    on<RegistrationScreenBadCreditalsEvent>((event, emit) {
      emit(RegistrationScreenBadCreditalsState());
    });

    on<RegistrationScreenSuccessEvent>((event, emit) {
      emit(RegistrationScreenSuccessState());
    });
  }
}
