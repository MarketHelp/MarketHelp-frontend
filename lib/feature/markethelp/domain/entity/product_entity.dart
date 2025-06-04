import 'package:json_annotation/json_annotation.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/visualization_entity.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  final String id;
  // final String shopId;
  final String name;
  // final String imageUrl;
  // final double price;
  // final double rating;
  final bool hasVisualization;

  @JsonKey(defaultValue: <String>[])
  late List<VisualizationEntity> visuals;

  ProductEntity({
    required this.id,
    // required this.shopId,
    required this.name,
    // required this.imageUrl,
    // required this.price,
    // required this.rating,
    required this.hasVisualization,
    this.visuals = const <VisualizationEntity>[],
    // this.chartImageUrls,
  });

  void addVisuals(List<VisualizationEntity> charts) {
    if (visuals.isEmpty) {
      visuals = charts;
    } else {
      visuals.addAll(charts);
    }
  }

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  // void addChartImageUrls(List<String> urls) {
  //   if (chartImageUrls == null) {
  //     chartImageUrls = urls;
  //   } else {
  //     chartImageUrls!.addAll(urls);
  //   }
  // }
}
