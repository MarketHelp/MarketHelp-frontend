import 'package:flutter_html/flutter_html.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visualization_entity.g.dart';

@JsonSerializable()
class VisualizationEntity {
  final String id;
  final VisualizationFormat format;

  @JsonKey(defaultValue: 0)
  late int shopId;
  @JsonKey(defaultValue: '')
  late String productId;
  @JsonKey(defaultValue: "")
  late String content;

  VisualizationEntity({
    required this.id,
    required this.format,
    this.shopId = 0,
    this.productId = '',
    this.content = '',
  });
  factory VisualizationEntity.fromJson(Map<String, dynamic> json) =>
      _$VisualizationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisualizationEntityToJson(this);

  void addContent(String newContent) {
    if (content.isEmpty) {
      content = newContent;
    } else {
      content += newContent;
    }
  }

  void addShopId(int newShopId) {
    if (shopId == 0) {
      shopId = newShopId;
    }
  }

  void addProductId(String newProductId) {
    if (productId.isEmpty) {
      productId = newProductId;
    }
  }
}

@JsonEnum()
enum VisualizationFormat {
  @JsonValue('bar')
  bar,
  @JsonValue('pie')
  pie,
  @JsonValue('all')
  all,
}
