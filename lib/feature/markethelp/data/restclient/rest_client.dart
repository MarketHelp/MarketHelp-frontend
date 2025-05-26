//TODO: MAKE THIS IN NORMAL IMPLEMENTATION

import 'package:dio/dio.dart' hide Headers;
import 'package:markethelp_frontend/core/constants/constants.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: MarketHelpConstants.server)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/shops')
  @Headers(MarketHelpConstants.headers)
  Future<List<ShopEntity>> getShops(@Header("Authorization") String token);
}
