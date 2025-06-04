import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';

abstract class ShopRepository {
  /// Получает список магазинов (API-ключей)
  Future<List<ShopEntity>> getShops();

  /// Добавляет новый магазин и привязывает к нему API-ключ
  Future<ShopEntity> addShop({
    required String name,
    required String apiKeyContent,
    DateTime? validUntil,
  });

  /// Удаляет магазин по ID (удаляется связанный API-ключ)
  Future<void> deleteShop(String id);

  /// Редактирует данные магазина
  Future<ShopEntity> updateShop({
    required String id,
    String? name,
    DateTime? validUntil,
  });
}
