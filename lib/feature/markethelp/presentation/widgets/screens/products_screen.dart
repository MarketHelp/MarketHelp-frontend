import 'package:flutter/material.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/products/product_tile.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/search_box.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(withSettings: true, screenTitle: 'Товары'),
      body: Column(
        children: [
          // Search box at the top
          SearchBox(withSettings: true),
          // This Expanded is crucial - it prevents the Column + ListView crash
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ProductTile(
                  productName: "Product $index",
                  rating: 4.5,
                  logoUrl: "https://example.com/logo.png",
                  onTap: () {
                    // Handle shop tile tap
                    Navigator.pushNamed(
                      context,
                      '/analytics',
                      arguments: {
                        'productName': "Product $index",
                        'rating': 4.5,
                        'productImageUrl': "https://example.com/logo.png",
                        'price': '1 ₽',
                      },
                    );
                  },
                  withAnalytics:
                      index % 2 == 0
                          ? true
                          : false, // Set to true to enable analytics
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
