import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/core/constants/constants.dart';
import 'package:markethelp_frontend/feature/markethelp/data/restclient/rest_client.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopRepositoryImpl extends ShopRepository {
  RestClient restClient = GetIt.I<RestClient>();
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  // List<ShopEntity> shops = [
  //   //test datd
  //   ShopEntity(
  //     id: '1',
  //     name: 'У дяди ашота',
  //     rating: 4.5,
  //     apiKey: 'API Key 1',
  //     validUntil: DateTime.now().add(Duration(days: 30)),
  //   ),
  //   ShopEntity(
  //     id: '2',
  //     name: 'ШрексШоп',
  //     rating: 5,
  //     apiKey: 'API Key 2',
  //     validUntil: DateTime.now().add(Duration(days: 60)),
  //   ),
  // ];

  @override
  Future<ShopEntity> addShop({
    required String name,
    required String apiKeyContent,
    DateTime? validUntil,
  }) {
    return Future.value(ShopEntity(id: 1, name: "aaa"));
  }

  @override
  Future<void> deleteShop(String id) {
    // TODO: implement deleteShop
    throw UnimplementedError();
  }

  @override
  Future<List<ShopEntity>> getShops() {
    print('Fetching shops from API...');
    print(MarketHelpConstants.headers);
    print(sharedPreferences.getString('token') ?? "No token found");
    return restClient
        .getShops('Bearer ' + (sharedPreferences.getString('token') ?? ""))
        .then((value) {
          return value;
        })
        .catchError((error) {
          print('Error fetching shops: $error');
          return [];
        });
  }

  @override
  Future<ShopEntity> updateShop({
    required String id,
    String? name,
    DateTime? validUntil,
  }) {
    // TODO: implement updateShop
    throw UnimplementedError();
  }
}
