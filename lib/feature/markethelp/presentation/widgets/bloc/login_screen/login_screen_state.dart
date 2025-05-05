part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenState {
  final bool isCorrect;
  final bool isSuccess = false;
  const LoginScreenState({this.isCorrect = true});
}

final class LoginScreenCorrectState extends LoginScreenState {
  final bool isCorrect;
  final bool isSuccess = false;
  LoginScreenCorrectState({required this.isCorrect});
}

final class LoginScreenSuccessState extends LoginScreenState {
  final bool isCorrect = true;
  final bool isSuccess = true;
  LoginScreenSuccessState();
}

final class LoginScreenBadCreditalsState extends LoginScreenState {
  final bool isCorrect = false;
  final bool isSuccess = false;
  LoginScreenBadCreditalsState();
}
