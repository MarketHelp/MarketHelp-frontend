import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:retrofit/dio.dart';
import 'package:markethelp_frontend/feature/markethelp/data/restclient/rest_client.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/product_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/visualization_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImpl extends ProductRepository {
  RestClient restClient = GetIt.I<RestClient>();
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  @override
  Future<List<String>> generateVisualization(
    int shopId,
    String productId, {
    Map<String, dynamic>? filters,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getProductAdvices(String productId) {
    // TODO: implement getProductAdvices
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getProducts(int shopId) {
    return restClient
        .getProducts(
          shopId,
          'Bearer ' + (sharedPreferences.getString('token') ?? ""),
        )
        .then((value) {
          return value;
        })
        .catchError((error) {
          print('Error fetching products: $error');
          return [];
        });
  }

  @override
  Future<void> syncProducts() {
    // TODO: implement syncProducts
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<List<int>>> getVisualization(
    int shopId,
    String productId,
    String visualizationId,
  ) async {
    return restClient.getVisualization(
      shopId,
      productId,
      visualizationId,
      'Bearer ' + (sharedPreferences.getString('token') ?? ""),
    );
  }

  @override
  Future<List<VisualizationEntity>> getVisualizations(
    int shopId,
    String productId,
  ) async {
    List<VisualizationEntity> visuals = await restClient.getVisualizations(
      shopId,
      productId,
      'Bearer ' + (sharedPreferences.getString('token') ?? ""),
    );

    for (int i = 0; i < visuals.length; i++) {
      visuals[i].addProductId(productId);
      visuals[i].addShopId(shopId);
    }
    return Future.value(visuals);
  }
}
