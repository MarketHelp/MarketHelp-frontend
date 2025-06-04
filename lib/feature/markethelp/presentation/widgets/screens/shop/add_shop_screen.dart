import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/search_box_shop/search_box_shop_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';

class AddShopScreen extends StatelessWidget {
  final TextEditingController shopNameController;
  final TextEditingController apiKeyController;
  final VoidCallback onSubmit;

  const AddShopScreen({
    Key? key,
    required this.shopNameController,
    required this.apiKeyController,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(screenTitle: "Новый магазин"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: shopNameController,
              decoration: const InputDecoration(
                labelText: 'Название магазина',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: apiKeyController,
              decoration: InputDecoration(
                labelText: 'API ключ магазина',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () {
                    // Show API key help info
                  },
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final shopName = shopNameController.text;
                  final apiKey = apiKeyController.text;
                  final shopRepository = GetIt.instance<ShopRepository>();
                  shopRepository
                      .addShop(name: shopName, apiKeyContent: apiKey)
                      .then((_) {
                        BlocProvider.of<SearchBoxShopBloc>(
                          context,
                        ).add(SearchBoxUpdateEvent());
                        Navigator.pop(context);
                      })
                      .catchError((error) {
                        // Handle error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $error')),
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C27B0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Добавить',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
