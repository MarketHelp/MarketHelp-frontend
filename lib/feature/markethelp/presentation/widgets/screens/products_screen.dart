import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/search_box_product/search_box_product_bloc.dart';
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
          SearchBox(
            onSearchChanged: (query) {
              // Handle search text changes
              context.read<SearchBoxProductBloc>().add(
                SearchBoxProductTextChangedEvent(query),
              );
            },
            onFilterTap: () {
              // Handle settings icon tap
              print('filter icon tapped!');
            },
            withSettings: true,
            hintText: "Найти товар",
          ),
          // This Expanded is crucial - it prevents the Column + ListView crash
          BlocBuilder<SearchBoxProductBloc, SearchBoxProductState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductTile(
                      productName: product.name,
                      rating: product.rating,
                      logoUrl: product.imageUrl,
                      onTap: () {
                        // Handle product tile tap
                        Navigator.pushNamed(
                          context,
                          '/analytics',
                          arguments: {
                            'productName': product.name,
                            'rating': product.rating,
                            'productImageUrl': product.imageUrl,
                            'price': '1 ₽',
                          },
                        );
                      },
                      withAnalytics: product.visualizationAvailable,
                      timeData: '12:00',
                      chartImageUrls:
                          product.visualizationAvailable
                              ? [
                                "https://asu-analitika.ru/wp-content/uploads/2019/09/02-700x441.png",
                                "https://asu-analitika.ru/wp-content/uploads/2019/09/02-700x441.png",
                              ]
                              : null,
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
