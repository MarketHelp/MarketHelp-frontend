import 'package:flutter/material.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/analysis/chart.dart';

enum ProductTileType { basic, withAnalytics }

class ProductTile extends StatelessWidget {
  final String productName;
  final double rating;
  final String? logoUrl;
  final VoidCallback? onTap;
  final ProductTileType tileType;
  final String? timeData;
  final List<String>? chartImageUrls;

  const ProductTile._({
    Key? key,
    required this.productName,
    this.rating = 0.0,
    this.logoUrl,
    this.onTap,
    required this.tileType,
    this.timeData,
    this.chartImageUrls,
  }) : super(key: key);

  // Factory constructor that delegates to the right implementation
  factory ProductTile({
    Key? key,
    required String productName,
    double rating = 0.0,
    String? logoUrl,
    VoidCallback? onTap,
    bool? withAnalytics,
    String? timeData,
    ProductTileType? type,
    List<String>? chartImageUrls,
  }) {
    // Determine the type based on parameters
    ProductTileType tileType =
        type ??
        (withAnalytics == true
            ? ProductTileType.withAnalytics
            : ProductTileType.basic);

    return ProductTile._(
      key: key,
      productName: productName,
      rating: rating,
      logoUrl: logoUrl,
      onTap: onTap,
      tileType: tileType,
      timeData: timeData ?? '12:00',
      chartImageUrls: chartImageUrls,
    );
  }

  // Named constructor for basic tile
  factory ProductTile.basic({
    Key? key,
    required String productName,
    double rating = 0.0,
    String? logoUrl,
    VoidCallback? onTap,
  }) {
    return ProductTile._(
      key: key,
      productName: productName,
      rating: rating,
      logoUrl: logoUrl,
      onTap: onTap,
      tileType: ProductTileType.basic,
    );
  }

  // Named constructor for analytics tile
  factory ProductTile.withAnalytics({
    Key? key,
    required String productName,
    double rating = 0.0,
    String? logoUrl,
    VoidCallback? onTap,
    String timeData = '12:00',
    List<String>? chartImageUrls,
  }) {
    return ProductTile._(
      key: key,
      productName: productName,
      rating: rating,
      logoUrl: logoUrl,
      onTap: onTap,
      tileType: ProductTileType.withAnalytics,
      timeData: timeData,
      chartImageUrls: chartImageUrls,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (tileType) {
      case ProductTileType.basic:
        return _buildBasicTile(context);
      case ProductTileType.withAnalytics:
        return _buildAnalyticsTile(context);
      default:
        return _buildBasicTile(context);
    }
  }

  Widget _buildBasicTile(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Navigator.pushNamed(
              context,
              '/analytics',
              arguments: {
                'productName': productName,
                'rating': rating,
                'logoUrl': logoUrl,
              },
            );
          },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFD6C9F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              // Main content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product logo
                  _buildLogo(),
                  const SizedBox(width: 12),
                  // Product info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              // Rating positioned at bottom right
              Positioned(bottom: 0, right: 0, child: _buildRating(rating)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsTile(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFD6C9F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  // Main content
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product logo
                      _buildLogo(),
                      const SizedBox(width: 12),
                      // Product info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        timeData ?? '12:00',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  // Rating positioned at bottom right
                  Positioned(bottom: 0, right: 0, child: _buildRating(rating)),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ChartWidget(
                          imageUrl:
                              chartImageUrls?.isNotEmpty == true
                                  ? chartImageUrls![0]
                                  : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ChartWidget(
                          imageUrl:
                              chartImageUrls != null &&
                                      chartImageUrls!.length > 1
                                  ? chartImageUrls![1]
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo({bool smaller = false}) {
    return Container(
      width: smaller ? 40 : 50,
      height: smaller ? 40 : 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child:
          logoUrl != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  logoUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.store, color: Colors.grey);
                  },
                ),
              )
              : const Icon(Icons.store, color: Colors.grey),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.purple,
              size: 14,
            );
          }),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
