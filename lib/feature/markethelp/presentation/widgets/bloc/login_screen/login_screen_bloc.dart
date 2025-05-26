import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final AuthRepository authRepository = GetIt.I<AuthRepository>();
  final SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  LoginScreenBloc() : super(LoginScreenCorrectState(isCorrect: true)) {
    on<LoginScreenCheckEvent>((event, emit) async {
      AuthCredentials credentials = AuthCredentials(
        login: event.login,
        password: event.password,
      );

      final result = await authRepository.login(credentials);
      sharedPreferences.setString(
        'token',
        result.fold((error) => '', (token) => token.token),
      );

      print(sharedPreferences.getString('token'));

      result.fold(
        (error) {
          add(LoginScreenBadCreditalsEvent());
          emit(LoginScreenBadCreditalsState());
        },
        (token) {
          add(LoginScreenSuccessEvent());
          emit(LoginScreenSuccessState());
        },
      );
    });
    on<LoginScreenBadCreditalsEvent>((event, emit) {
      emit(LoginScreenBadCreditalsState());
    });
    on<LoginScreenSuccessEvent>((event, emit) {
      emit(LoginScreenSuccessState());
    });
  }
}
