class ShopEntity {
  final String id;
  final String name;
  final String? logoUrl;
  final String apiKey;
  final DateTime validUntil;
  final double rating;

  ShopEntity({
    required this.id,
    required this.name,
    this.logoUrl,
    required this.apiKey,
    required this.validUntil,
    required this.rating,
  });
}
