import 'package:markethelp_frontend/feature/markethelp/domain/entity/product_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<String>> generateVisualization(
    String shopId,
    String productId, {
    Map<String, dynamic>? filters,
  }) {
    Map<String, List<String>> visuals = Map<String, List<String>>.from({
      "1": ['id1', 'id2', 'id3'],
      "2": ['id4', 'id5', 'id6'],
    });

    return Future.value(visuals[shopId] ?? []);
  }

  @override
  Future<List<String>> getProductAdvices(String productId) {
    // TODO: implement getProductAdvices
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getProducts(String shopId) {
    return Future.value(
      [
        ProductEntity(
          id: '1',
          shopId: '1',
          name: 'Удочка золотая',
          price: 10.0,
          rating: 4.5,
          imageUrl:
              'https://img.joomcdn.net/e1e3ef0dc63f9ba7db83dc64d181280beaa4470f_1024_1024.jpeg',
          visualizationAvailable: true,
        ),
        ProductEntity(
          id: '2',
          shopId: '2',
          name: 'Вечный шрекс',
          price: 20.0,
          rating: 4.0,
          imageUrl:
              'https://www.meme-arsenal.com/memes/13baee4e0ecfe88ecf88e0b00f0129a5.jpg',
          visualizationAvailable: false,
        ),
      ].where((product) => product.shopId == shopId).toList(),
    );
  }

  @override
  Future<void> syncProducts() {
    // TODO: implement syncProducts
    throw UnimplementedError();
  }
}
