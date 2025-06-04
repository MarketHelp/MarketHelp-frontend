// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      hasVisualization: json['hasVisualization'] as bool,
      visuals:
          (json['visuals'] as List<dynamic>?)
              ?.map(
                (e) => VisualizationEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hasVisualization': instance.hasVisualization,
      'visuals': instance.visuals,
    };
