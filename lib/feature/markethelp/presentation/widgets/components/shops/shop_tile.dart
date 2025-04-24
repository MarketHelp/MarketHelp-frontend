import 'package:flutter/material.dart';

class ShopTile extends StatelessWidget {
  final String shopName;
  final String apiKey;
  final double rating;
  final String? logoUrl;
  final VoidCallback? onTap;

  const ShopTile({
    Key? key,
    required this.shopName,
    required this.apiKey,
    this.rating = 0.0,
    this.logoUrl,
    this.onTap,
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
          child: Stack(
            children: [
              // Main content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shop logo
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
                  // Shop info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shopName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          apiKey,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
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
