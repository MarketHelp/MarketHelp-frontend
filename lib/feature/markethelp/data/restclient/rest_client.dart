//TODO: MAKE THIS IN NORMAL IMPLEMENTATION

import 'package:dio/dio.dart' hide Headers;
import 'package:markethelp_frontend/core/constants/constants.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/product_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/visualization_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: MarketHelpConstants.server)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/shops')
  @Headers(MarketHelpConstants.headers)
  Future<List<ShopEntity>> getShops(@Header("Authorization") String token);

  @GET('/shops/{shopId}/products')
  @Headers(MarketHelpConstants.headers)
  Future<List<ProductEntity>> getProducts(
    @Path("shopId") int shopId,
    @Header("Authorization") String token,
  );

  @GET('/shops/{shopId}/products/{productId}/visualizations')
  @Headers(MarketHelpConstants.headers)
  Future<List<VisualizationEntity>> getVisualizations(
    @Path("shopId") int shopId,
    @Path("productId") String productId,
    @Header("Authorization") String token,
  );

  @GET('/shops/{shopId}/products/{productId}/visualizations/{visualizationId}')
  @Headers(MarketHelpConstants.headers)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> getVisualization(
    @Path("shopId") int shopId,
    @Path("productId") String productId,
    @Path("visualizationId") String visualizationId,
    @Header("Authorization") String token,
  );
}
