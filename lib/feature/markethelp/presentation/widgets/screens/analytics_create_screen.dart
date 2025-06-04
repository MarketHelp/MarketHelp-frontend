import 'package:flutter/material.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/visualization_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class AnalyticsCreateScreen extends StatelessWidget {
  // Controllers for the dropdowns
  final categoriesController = MultiSelectController<String>();
  final ratingsController = MultiSelectController<String>();
  final rangeController = MultiSelectController<String>();
  final moodController = MultiSelectController<String>();

  // Example values for dropdowns using DropdownItem format
  final List<DropdownItem<String>> categories = [
    DropdownItem(label: 'Качество', value: 'quality'),
    DropdownItem(label: 'Доставка', value: 'delivery'),
    DropdownItem(label: 'Описание', value: 'description'),
    DropdownItem(label: 'Упаковка', value: 'packaging'),
  ];

  final List<DropdownItem<String>> ratings = [
    DropdownItem(label: '★', value: '1'),
    DropdownItem(label: '★★', value: '2'),
    DropdownItem(label: '★★★', value: '3'),
    DropdownItem(label: '★★★★', value: '4'),
    DropdownItem(label: '★★★★★', value: '5'),
  ];

  final List<DropdownItem<String>> ranges = [
    DropdownItem(label: 'Неделя', value: 'week'),
    DropdownItem(label: 'Месяц', value: 'month'),
    DropdownItem(label: 'Квартал', value: 'quarter'),
    DropdownItem(label: 'Год', value: 'year'),
  ];

  final List<DropdownItem<String>> moods = [
    DropdownItem(label: 'Позитивные', value: 'positive'),
    DropdownItem(label: 'Нейтральные', value: 'neutral'),
    DropdownItem(label: 'Негативные', value: 'negative'),
  ];

  AnalyticsCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String productName = args['productName'] ?? 'Unknown Product';
    final double rating = args['rating'] ?? 0.0;
    final List<VisualizationEntity>? visuals = args['visuals'];
    final String price = args['price'].toString() + " ₽" ?? '0 ₽';
    final String description =
        args['description'] ?? 'No description available';
    final List<String> chartImageUrls = args['chartImageUrls'] ?? [];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: Header(
        screenTitle: 'Настройка анализа',
      ), // Purple color from screenshot
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Description text
              Padding(
                padding: const EdgeInsets.only(top: 144.0, bottom: 8.0),
                child: Text(
                  'Выберите параметры, по которым будет проводиться анализ отзывов',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Scrollable content area
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      // Multi-select Category dropdown
                      MultiDropdown<String>(
                        controller: categoriesController,
                        items: categories,
                        fieldDecoration: FieldDecoration(
                          hintText: 'Категории',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          backgroundColor: Colors.white,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                          wrap: true,
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {},
                      ),
                      const SizedBox(height: 12),

                      // Multi-select Rating dropdown
                      MultiDropdown<String>(
                        controller: ratingsController,
                        items: ratings,
                        fieldDecoration: FieldDecoration(
                          hintText: 'Рейтинг',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          backgroundColor: Colors.white,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                          wrap: true,
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {},
                      ),
                      const SizedBox(height: 12),

                      // Single-select Range dropdown
                      MultiDropdown<String>(
                        controller: rangeController,
                        items: ranges,
                        singleSelect: true,
                        fieldDecoration: FieldDecoration(
                          hintText: 'Диапазон',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          backgroundColor: Colors.white,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {},
                      ),
                      const SizedBox(height: 12),

                      // Single-select Mood dropdown
                      MultiDropdown<String>(
                        controller: moodController,
                        items: moods,
                        singleSelect: true,
                        fieldDecoration: FieldDecoration(
                          hintText: 'Настроение',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          backgroundColor: Colors.white,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {},
                      ),
                    ],
                  ),
                ),
              ),

              // Analyze button at the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/analytics',
                        arguments: {
                          'productName': productName,
                          'rating': rating,
                          'visuals': visuals,
                          'price': price,
                          'description': description,
                          'chartImageUrls': chartImageUrls,
                          'categories':
                              categoriesController.selectedItems
                                  .map((item) => item.value)
                                  .toList(),
                          'ratings':
                              ratingsController.selectedItems
                                  .map((item) => item.value)
                                  .toList(),
                          'range':
                              rangeController.selectedItems.isNotEmpty
                                  ? rangeController.selectedItems.first.value
                                  : null,
                          'mood':
                              moodController.selectedItems.isNotEmpty
                                  ? moodController.selectedItems.first.value
                                  : null,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8257E6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Анализировать',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
