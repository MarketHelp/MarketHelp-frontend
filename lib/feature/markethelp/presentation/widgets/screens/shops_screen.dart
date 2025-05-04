import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/search_box_shop/search_box_shop_bloc.dart';
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
          SearchBox(
            onSearchChanged: (query) {
              // Handle search text changes
              context.read<SearchBoxShopBloc>().add(
                SearchBoxShopTextChangedEvent(query),
              );
            },
          ),
          // This Expanded is crucial - it prevents the Column + ListView crash
          BlocBuilder<SearchBoxShopBloc, SearchBoxShopState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.shops.length,
                  itemBuilder: (context, index) {
                    final shop = state.shops[index];
                    return ShopTile(
                      shopName: shop.name,
                      apiKey: shop.apiKey,
                      rating: shop.rating,
                      logoUrl: shop.logoUrl,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
