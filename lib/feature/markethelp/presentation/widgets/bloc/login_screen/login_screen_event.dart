part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent {}

class LoginScreenBadCreditalsEvent extends LoginScreenEvent {}

class LoginScreenCheckEvent extends LoginScreenEvent {
  final String login;
  final String password;

  LoginScreenCheckEvent({required this.login, required this.password});
}

class LoginScreenSuccessEvent extends LoginScreenEvent {
  LoginScreenSuccessEvent();
}
