import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/search_box_product/search_box_product_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/products/product_tile.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/search_box.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final int shopId = args['shopId'] ?? null;
    context.read<SearchBoxProductBloc>().add(SearchBoxProductLoadEvent(shopId));

    //MVP Only
    ProductRepository _productRepository = GetIt.I<ProductRepository>();

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
              if (state.products.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No products found')),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductTile(
                      productName: product.name,
                      rating: 4.5,
                      // logoUrl: product.imageUrl,
                      onTap: () {
                        // Handle product tile tap
                        Navigator.pushNamed(
                          context,
                          '/createAnalytics',
                          arguments: {
                            'productName': product.name,
                            'visuals': product.visuals,
                            // 'rating': product.rating,
                            // 'productImageUrl': product.imageUrl,
                            // 'price': product.price,
                            // 'chartImageUrls': product.chartImageUrls,
                          },
                        );
                      },
                      withAnalytics: product.hasVisualization,
                      timeData: '12:00',
                      visuals: product.visuals,
                      // chartImageUrls:
                      //     product.visualizationAvailable
                      //         ? product.chartImageUrls
                      //         : null,
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
