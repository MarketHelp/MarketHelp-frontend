part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenEvent {}

class InitialStateEvent extends MainScreenEvent {}

class AuthSuccessEvent extends MainScreenEvent {}

class LoginScreenEvent extends MainScreenEvent {}

class RegistrationScreenEvent extends MainScreenEvent {}

class ShopsScreenEvent extends MainScreenEvent {}

class ProductsScreenEvent extends MainScreenEvent {}
