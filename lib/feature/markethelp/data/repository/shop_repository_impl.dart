import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';

class ShopRepositoryImpl extends ShopRepository {
  List<ShopEntity> shops = [
    ShopEntity(
      id: '1',
      name: 'У дяди ашота',
      rating: 4.5,
      apiKey: 'API Key 1',
      validUntil: DateTime.now().add(Duration(days: 30)),
    ),
    ShopEntity(
      id: '2',
      name: 'ШрексШоп',
      rating: 5,
      apiKey: 'API Key 2',
      validUntil: DateTime.now().add(Duration(days: 60)),
    ),
  ];

  @override
  Future<ShopEntity> addShop({
    required String name,
    required String apiKeyContent,
    DateTime? validUntil,
  }) {
    ShopEntity shop = ShopEntity(
      id: '3',
      name: name,
      apiKey: apiKeyContent,
      validUntil: DateTime.now(),
      rating: 4.5,
    );
    shops.add(shop);
    return Future.value(shop);
  }

  @override
  Future<void> deleteShop(String id) {
    // TODO: implement deleteShop
    throw UnimplementedError();
  }

  @override
  Future<List<ShopEntity>> getShops() {
    return Future.value(shops);
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
