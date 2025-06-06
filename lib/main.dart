import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/login_screen/login_screen_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/main_screen/main_screen_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/registration_screen/registration_screen_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/search_box_product/search_box_product_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/search_box_shop/search_box_shop_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/analytics_create_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/auth_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/login_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/profile_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/registration_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/settings_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/shop/add_shop_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/shops_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/products_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/analiytics_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/tariff_screen.dart';
import 'package:markethelp_frontend/injector.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await initDependencies();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBoxShopBloc()),
        BlocProvider(create: (context) => SearchBoxProductBloc()),
        BlocProvider(
          create: (context) {
            return MainScreenBloc()..add(InitialStateEvent());
          },
        ),
        BlocProvider(create: (context) => LoginScreenBloc()),
        BlocProvider(create: (context) => RegistrationScreenBloc()),
      ],
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue),
            routes: {
              '/shops': (context) => ShopsScreen(),
              '/products': (context) => ProductsScreen(),
              '/analytics': (context) => AnalyticsScreen(),
              '/login': (context) => LoginScreen(),
              '/auth': (context) => AuthScreen(),
              '/registration': (context) => RegistrationScreen(),
              '/addShop':
                  (context) => AddShopScreen(
                    shopNameController: TextEditingController(),
                    apiKeyController: TextEditingController(),
                    onSubmit: () {},
                  ),
              '/settings': (context) => SettingsScreen(),
              '/profile': (context) => ProfileScreen(),
              '/createAnalytics': (context) => AnalyticsCreateScreen(),
              '/tariff': (context) => const TariffScreen(),
            },
            home: state.currentScreen,
          );
        },
      ),
    );
  }
}
