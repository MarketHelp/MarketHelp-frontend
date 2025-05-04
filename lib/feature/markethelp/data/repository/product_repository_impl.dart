import 'package:markethelp_frontend/feature/markethelp/domain/entity/product_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<String> generateVisualization(
    String productId,
    String chartType, {
    Map<String, dynamic>? filters,
  }) {
    // TODO: implement generateVisualization
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getProductAdvices(String productId) {
    // TODO: implement getProductAdvices
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getProducts() {
    return Future.value([
      ProductEntity(
        id: '1',
        name: 'Product 1',
        price: 10.0,
        rating: 4.5,
        imageUrl: 'https://example.com/product1.png',
        visualizationAvailable: true,
      ),
      ProductEntity(
        id: '2',
        name: 'Product 2',
        price: 20.0,
        rating: 4.0,
        imageUrl: 'https://example.com/product2.png',
        visualizationAvailable: false,
      ),
    ]);
  }

  @override
  Future<void> syncProducts() {
    // TODO: implement syncProducts
    throw UnimplementedError();
  }
}
