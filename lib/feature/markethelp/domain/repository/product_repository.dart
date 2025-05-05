import 'package:markethelp_frontend/feature/markethelp/domain/entity/product_entity.dart';
// import 'package:markethelp_frontend/feature/markethelp/domain/entity/review_entity.dart';

/// Repository interface for product-related operations
abstract class ProductRepository {
  /// Get list of products from connected shops
  Future<List<ProductEntity>> getProducts(String shopId);

  /// Synchronize product data with Yandex Market
  Future<void> syncProducts();

  /// Get reviews for a specific product with filters
  // Future<List<ReviewEntity>> getProductReviews(String productId, {Map<String, dynamic>? filters});

  /// Generate visualization for a product
  /// should be a image
  Future<String> generateVisualization(
    String productId,
    String chartType, {
    Map<String, dynamic>? filters,
  });

  /// Get AI-powered recommendations for improving a product
  Future<List<String>> getProductAdvices(String productId);
}
