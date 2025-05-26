import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/data/repository/auth_repository_impl.dart';
import 'package:markethelp_frontend/feature/markethelp/data/repository/product_repository_impl.dart';
import 'package:markethelp_frontend/feature/markethelp/data/repository/shop_repository_impl.dart';
import 'package:markethelp_frontend/feature/markethelp/data/restclient/rest_client.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/auth_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/usecase/analytics_uscase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance().catchError((
    error,
  ) {
    print('Error initializing SharedPreferences: $error');
    // Return a mock implementation or throw an error based on your needs
    throw error;
  });

  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<RestClient>(RestClient(Dio()));
  sl.registerSingleton<ShopRepository>(ShopRepositoryImpl());
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  sl.registerSingleton<SharePlus>(SharePlus.instance);
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<AnalyticsUsecase>(AnalyticsUsecase());

  // Initialize SharedPreferences properly
}
