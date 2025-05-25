import 'package:flutter/material.dart';
import '../components/dropdown/base_select_dropdown.dart';

class AnalyticsCreateScreen extends StatefulWidget {
  const AnalyticsCreateScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsCreateScreen> createState() => _AnalyticsCreateScreenState();
}

class _AnalyticsCreateScreenState extends State<AnalyticsCreateScreen> {
  // Variables to store selected values for each dropdown
  List<String> selectedCategories = [];
  List<String> selectedRatings = [];
  List<String> selectedRanges = [];
  List<String> selectedMoods = [];

  // Example values for dropdowns
  final List<String> categories = ['Одежда', 'Техника', 'Еда', 'Книги'];
  final List<String> ratings = [
    '1 звезда',
    '2 звезды',
    '3 звезды',
    '4 звезды',
    '5 звезд',
  ];
  final List<String> ranges = ['Неделя', 'Месяц', 'Квартал', 'Год'];
  final List<String> moods = ['Позитивные', 'Нейтральные', 'Негативные'];

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

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF8257E6,
        ), // Purple color from screenshot
        title: const Text(
          'Настройка анализа',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Make content scrollable
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Description text
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Выберите параметры, по которым будет проводиться анализ отзывов',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Category dropdown
                      BaseSelectDropdown(
                        name: 'Категории',
                        values: categories,
                        initialDropDownHeader:
                            selectedCategories.isEmpty
                                ? ''
                                : '${selectedCategories.length} выбрано',
                      ),
                      const SizedBox(height: 12),

                      // Rating dropdown
                      BaseSelectDropdown(
                        name: 'Рейтинг',
                        values: ratings,
                        initialDropDownHeader:
                            selectedRatings.isEmpty
                                ? ''
                                : '${selectedRatings.length} выбрано',
                      ),
                      const SizedBox(height: 12),

                      // Range dropdown
                      BaseSelectDropdown(
                        name: 'Диапазон',
                        values: ranges,
                        initialDropDownHeader:
                            selectedRanges.isEmpty
                                ? ''
                                : '${selectedRanges.length} выбрано',
                      ),
                      const SizedBox(height: 12),

                      // Mood dropdown
                      BaseSelectDropdown(
                        name: 'Настроение',
                        values: moods,
                        initialDropDownHeader:
                            selectedMoods.isEmpty
                                ? ''
                                : '${selectedMoods.length} выбрано',
                      ),

                      // Add extra space at the bottom for better spacing
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Analyze button - outside the scrollview but still at the bottom
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/analytics',
                    arguments: {
                      'productName': productName,
                      'rating': rating,
                      'productImageUrl': productImageUrl,
                      'price': price,
                      'description': description,
                      'chartImageUrls': chartImageUrls,
                      'categories': selectedCategories,
                      'ratings': selectedRatings,
                      'ranges': selectedRanges,
                      'moods': selectedMoods,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8257E6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25,
                    ), // Rounded corners as shown in screenshot
                  ),
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ), // Ensure button has good height
                ),
                child: const Text(
                  'Анализировать',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
