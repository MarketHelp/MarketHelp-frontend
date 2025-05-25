import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/usecase/analytics_uscase.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/analysis/chart.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';
import 'package:share_plus/share_plus.dart';

class AnalyticsScreen extends StatelessWidget {
  // final String productName;
  // final double rating;
  // final String? productImageUrl;
  // final String price;
  final SharePlus _sharePlus = GetIt.I<SharePlus>();

  // AnalyticsScreen({
  //   Key? key,
  //   this.productName = 'Name',
  //   this.rating = 5.0,
  //   this.productImageUrl,
  //   this.price = '1 ₽',
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String productName = args['productName'] ?? 'Unknown Product';
    final double rating = args['rating'] ?? 0.0;
    final String? productImageUrl = args['productImageUrl'];
    final String price = args['price'] ?? '0 ₽';
    final String description =
        args['description'] ?? 'No description available';
    final List<String> chartImageUrls = args['chartImageUrls'] ?? [];

    // Extract the filter parameters from AnalyticsCreateScreen
    final List<String> selectedCategories = args['categories'] ?? [];
    final List<String> selectedRatings = args['ratings'] ?? [];
    final List<String> selectedRanges = args['ranges'] ?? [];
    final List<String> selectedMoods = args['moods'] ?? [];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: Header(screenTitle: "Анализ"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product card
              _buildProductCard(productName, rating, productImageUrl, price),

              const SizedBox(height: 16),

              // Description section
              const Text(
                'Описание',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 14)),

              const SizedBox(height: 16),

              ChartWidget(
                imageUrl:
                    chartImageUrls.isNotEmpty
                        ? chartImageUrls[0]
                        : '', // Replace with your chart URL
                height: 200,
                width: double.infinity,
              ),

              SizedBox(height: 16),

              ChartWidget(
                imageUrl:
                    chartImageUrls.isNotEmpty && chartImageUrls.length > 1
                        ? chartImageUrls[1]
                        : '', // Replace with your chart URL
                height: 200,
                width: double.infinity,
              ),

              // Recommendations
              const Text(
                'Рекомендации',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              const Text(
                'Заглушка под рекомендации',
                style: TextStyle(fontSize: 14),
              ),

              SizedBox(height: 24),

              // Action buttons
              _buildExportButton(),
              const SizedBox(height: 12),

              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String productName,
    double rating,
    String? productImageUrl,
    String price,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD6C9F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                productImageUrl != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        productImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image, color: Colors.grey);
                        },
                      ),
                    )
                    : const Icon(Icons.image, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: const Color(0xFF9966CC),
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${rating.toStringAsFixed(1)}'),
                  ],
                ),
              ],
            ),
          ),
          // Price
          Text(
            price,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          AnalyticsUsecase a = AnalyticsUsecase();
          String s = await a.downloadFile(
            url:
                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png",
          );
          final params = ShareParams(
            text: "Аналитика из MarketHelp",
            files: [XFile(s)],
          );

          await _sharePlus.share(params);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9966CC),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Экспортировать',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF9966CC)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Вернуться к товарам',
          style: TextStyle(color: Color(0xFF9966CC), fontSize: 16),
        ),
      ),
    );
  }
}
