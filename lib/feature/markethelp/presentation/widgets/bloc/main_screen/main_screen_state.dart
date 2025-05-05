part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenState {
  final Widget currentScreen = const LoginScreen();
  MainScreenState();
}

class MainScreenInitialState extends MainScreenState {
  final Widget currentScreen = const LoginScreen();
  MainScreenInitialState();
}

class MainScreenCurrentState extends MainScreenState {
  final Widget currentScreen;
  MainScreenCurrentState({required this.currentScreen});
}
