// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visualization_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisualizationEntity _$VisualizationEntityFromJson(Map<String, dynamic> json) =>
    VisualizationEntity(
      id: json['id'] as String,
      format: $enumDecode(_$VisualizationFormatEnumMap, json['format']),
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      productId: json['productId'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );

Map<String, dynamic> _$VisualizationEntityToJson(
  VisualizationEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'format': _$VisualizationFormatEnumMap[instance.format]!,
  'shopId': instance.shopId,
  'productId': instance.productId,
  'content': instance.content,
};

const _$VisualizationFormatEnumMap = {
  VisualizationFormat.bar: 'bar',
  VisualizationFormat.pie: 'pie',
  VisualizationFormat.all: 'all',
};
