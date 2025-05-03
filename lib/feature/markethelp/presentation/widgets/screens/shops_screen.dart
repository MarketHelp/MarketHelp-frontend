import 'package:flutter/material.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/search_box.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/shops/shop_tile.dart';

class ShopsScreen extends StatelessWidget {
  ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        showBackButton: false,
        withSettings: true,
        screenTitle: 'Магазины',
      ),
      body: Column(
        children: [
          // Search box at the top
          SearchBox(),
          // This Expanded is crucial - it prevents the Column + ListView crash
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ShopTile(
                  shopName: "Shop $index",
                  apiKey: "api key $index",
                  rating: 4.5,
                  logoUrl: "https://example.com/logo.png",
                  onTap: () {
                    // Handle shop tile tap
                    Navigator.pushNamed(
                      context,
                      '/products',
                      arguments: {
                        // TODO: WAT ??????????????????????????
                        'shopName': "Shop $index",
                        'apiKey': "api key $index",
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
