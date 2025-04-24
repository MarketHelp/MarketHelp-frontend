import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String productName;

  final double rating;
  final String? logoUrl;
  final VoidCallback? onTap;
  final bool? withAnalytics; // Default value

  const ProductTile({
    Key? key,
    required this.productName,
    this.rating = 0.0,
    this.logoUrl,
    this.onTap,
    this.withAnalytics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFFD6C9F2),
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
                      Container(
                        width: 50,
                        height: 50,
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
                                      return const Icon(
                                        Icons.store,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                )
                                : const Icon(Icons.store, color: Colors.grey),
                      ),
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
                      if (withAnalytics == true)
                        Text(
                          '12:00',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                    ],
                  ),
                  // Rating positioned at bottom right
                  Positioned(bottom: 0, right: 0, child: _buildRating(rating)),
                ],
              ),
              if (withAnalytics == true)
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildChart()),
                        const SizedBox(width: 12),
                        Expanded(child: _buildChart()),
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

  Widget _buildChart() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade300, width: 1.5),
      ),
      child: Stack(
        children: [
          // Here you would integrate your actual chart widget
          // For now using a placeholder
          Center(
            child: Text(
              'Chart Placeholder',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          // Analytics icon in the bottom right
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.purple.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.trending_up, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
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
