part of 'registration_screen_bloc.dart';

@immutable
sealed class RegistrationScreenEvent {}

class RegistrationScreenCheckEvent extends RegistrationScreenEvent {
  final String login;
  final String password;

  RegistrationScreenCheckEvent({required this.login, required this.password});
}

class RegistrationScreenBadCreditalsEvent extends RegistrationScreenEvent {
  RegistrationScreenBadCreditalsEvent();
}

class RegistrationScreenSuccessEvent extends RegistrationScreenEvent {
  RegistrationScreenSuccessEvent();
}
