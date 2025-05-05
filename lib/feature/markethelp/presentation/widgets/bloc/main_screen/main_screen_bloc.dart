import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/auth_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/login_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/products_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/registration_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/shops_screen.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenInitialState()) {
    bool authenticated = false;
    ShopRepository shopRepository = GetIt.I<ShopRepository>();
    on<InitialStateEvent>((event, emit) async {
      if (authenticated) {
        List<ShopEntity> shops = await shopRepository.getShops();
        if (shops.length > 1) {
          emit(MainScreenCurrentState(currentScreen: ShopsScreen()));
        } else if (shops.isNotEmpty) {
          emit(MainScreenCurrentState(currentScreen: ProductsScreen()));
        } else {
          emit(MainScreenCurrentState(currentScreen: LoginScreen()));
        }
        emit(MainScreenCurrentState(currentScreen: ShopsScreen()));
      } else {
        emit(MainScreenCurrentState(currentScreen: AuthScreen()));
      }
    });

    on<AuthSuccessEvent>((event, emit) {
      authenticated = true;
      add(InitialStateEvent());
    });

    on<LoginScreenEvent>((event, emit) {
      emit(MainScreenCurrentState(currentScreen: LoginScreen()));
    });

    on<RegistrationScreenEvent>((event, emit) {
      emit(MainScreenCurrentState(currentScreen: RegistrationScreen()));
    });
  }
}
