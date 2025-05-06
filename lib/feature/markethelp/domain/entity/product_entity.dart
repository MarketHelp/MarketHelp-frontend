class ProductEntity {
  final String id;
  final String shopId;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final bool visualizationAvailable;
  List<String>? chartImageUrls;

  ProductEntity({
    required this.id,
    required this.shopId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.visualizationAvailable,
    this.chartImageUrls,
  });

  void addChartImageUrls(List<String> urls) {
    if (chartImageUrls == null) {
      chartImageUrls = urls;
    } else {
      chartImageUrls!.addAll(urls);
    }
  }
}
