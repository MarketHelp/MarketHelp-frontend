import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/data/repository/shop_repository_impl.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';
import 'package:share_plus/share_plus.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton<ShopRepository>(ShopRepositoryImpl());
  sl.registerSingleton<SharePlus>(SharePlus.instance);
}
