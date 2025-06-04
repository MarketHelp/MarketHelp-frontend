import 'package:json_annotation/json_annotation.dart';

part 'shop_entity.g.dart';

@JsonSerializable()
class ShopEntity {
  final int id;
  final String name;
  // final String? logoUrl;
  // final String apiKey;
  // final DateTime validUntil;
  // final double rating;

  ShopEntity({
    required this.id,
    required this.name,
    // this.logoUrl,
    // required this.apiKey,
    // required this.validUntil,
    // required this.rating,
  });

  factory ShopEntity.fromJson(Map<String, dynamic> json) =>
      _$ShopEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ShopEntityToJson(this);
}
