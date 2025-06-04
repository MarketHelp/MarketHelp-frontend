import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'registration_screen_event.dart';
part 'registration_screen_state.dart';

class RegistrationScreenBloc
    extends Bloc<RegistrationScreenEvent, RegistrationScreenState> {
  final AuthRepository authRepository = GetIt.I<AuthRepository>();
  final SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  RegistrationScreenBloc() : super(RegistrationScreenInitialState()) {
    on<RegistrationScreenCheckEvent>((event, emit) async {
      // Simulate a network call
      await Future.delayed(Duration(seconds: 2));

      AuthCredentials credentials = AuthCredentials(
        login: event.login,
        password: event.password,
      );

      final result = await authRepository.register(credentials);
      sharedPreferences.setString(
        'token',
        result.fold((error) => '', (token) => token.token),
      );

      print(sharedPreferences.getString('token'));

      result.fold(
        (error) {
          add(RegistrationScreenBadCreditalsEvent());
          emit(RegistrationScreenBadCreditalsState());
        },
        (token) {
          add(RegistrationScreenSuccessEvent());
          emit(RegistrationScreenSuccessState());
        },
      );
    });

    on<RegistrationScreenBadCreditalsEvent>((event, emit) {
      emit(RegistrationScreenBadCreditalsState());
    });

    on<RegistrationScreenSuccessEvent>((event, emit) {
      emit(RegistrationScreenSuccessState());
    });
  }
}
