import 'package:markethelp_frontend/feature/markethelp/domain/entity/product_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/visualization_entity.dart';
import 'package:retrofit/dio.dart';
// import 'package:markethelp_frontend/feature/markethelp/domain/entity/review_entity.dart';

/// Repository interface for product-related operations
abstract class ProductRepository {
  /// Get list of products from connected shops
  Future<List<ProductEntity>> getProducts(int shopId);

  /// Synchronize product data with Yandex Market
  Future<void> syncProducts();

  /// Get reviews for a specific product with filters
  // Future<List<ReviewEntity>> getProductReviews(String productId, {Map<String, dynamic>? filters});

  /// Generate visualization for a product
  /// should be a image
  Future<List<String>> generateVisualization(
    int shopId,
    String productId, {
    Map<String, dynamic>? filters,
  });

  Future<List<VisualizationEntity>> getVisualizations(
    int shopId,
    String productId,
  );

  Future<HttpResponse<List<int>>> getVisualization(
    int shopId,
    String productId,
    String visualizationId,
  );

  /// Get AI-powered recommendations for improving a product
  Future<List<String>> getProductAdvices(String productId);
}
