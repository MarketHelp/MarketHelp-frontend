part of 'registration_screen_bloc.dart';

@immutable
sealed class RegistrationScreenState {
  final bool isCorrect = true;
  final bool isSuccess = false;
}

final class RegistrationScreenInitialState extends RegistrationScreenState {
  final bool isCorrect = true;
  final bool isSuccess = false;
  RegistrationScreenInitialState();
}

final class RegistrationScreenBadCreditalsState
    extends RegistrationScreenState {
  final bool isCorrect = false;
  final bool isSuccess = false;
  RegistrationScreenBadCreditalsState();
}

final class RegistrationScreenCorrectState extends RegistrationScreenState {
  final bool isCorrect;
  final bool isSuccess = false;
  RegistrationScreenCorrectState({required this.isCorrect});
}

final class RegistrationScreenSuccessState extends RegistrationScreenState {
  final bool isCorrect = true;
  final bool isSuccess = true;
  RegistrationScreenSuccessState();
}
