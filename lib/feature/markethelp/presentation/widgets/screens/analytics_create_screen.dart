import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class AnalyticsCreateScreen extends StatefulWidget {
  const AnalyticsCreateScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsCreateScreen> createState() => _AnalyticsCreateScreenState();
}

class _AnalyticsCreateScreenState extends State<AnalyticsCreateScreen> {
  // Controllers for the dropdowns
  final categoriesController = MultiSelectController<String>();
  final ratingsController = MultiSelectController<String>();
  final rangeController = MultiSelectController<String>();
  final moodController = MultiSelectController<String>();

  // Example values for dropdowns using DropdownItem format
  final List<DropdownItem<String>> categories = [
    DropdownItem(label: 'Одежда', value: 'Одежда'),
    DropdownItem(label: 'Техника', value: 'Техника'),
    DropdownItem(label: 'Еда', value: 'Еда'),
    DropdownItem(label: 'Книги', value: 'Книги'),
  ];

  final List<DropdownItem<String>> ratings = [
    DropdownItem(label: '★', value: '1'),
    DropdownItem(label: '★★', value: '2'),
    DropdownItem(label: '★★★', value: '3'),
    DropdownItem(label: '★★★★', value: '4'),
    DropdownItem(label: '★★★★★', value: '5'),
  ];

  final List<DropdownItem<String>> ranges = [
    DropdownItem(label: 'Неделя', value: 'Неделя'),
    DropdownItem(label: 'Месяц', value: 'Месяц'),
    DropdownItem(label: 'Квартал', value: 'Квартал'),
    DropdownItem(label: 'Год', value: 'Год'),
  ];

  final List<DropdownItem<String>> moods = [
    DropdownItem(label: 'Позитивные', value: 'Позитивные'),
    DropdownItem(label: 'Нейтральные', value: 'Нейтральные'),
    DropdownItem(label: 'Негативные', value: 'Негативные'),
  ];

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

                      // Multi-select Category dropdown
                      MultiDropdown<String>(
                        controller: categoriesController,
                        items: categories,
                        fieldDecoration: FieldDecoration(
                          hintText: 'Категории',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color(0xFF8257E6),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                          wrap: true,
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {
                          // Selection handled by controller
                        },
                      ),
                      const SizedBox(height: 12),

                      // Multi-select Rating dropdown
                      MultiDropdown<String>(
                        controller: ratingsController,
                        items: ratings,
                        fieldDecoration: FieldDecoration(
                          hintText: 'Рейтинг',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color(0xFF8257E6),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                          wrap: true,
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {
                          // Selection handled by controller
                        },
                      ),
                      const SizedBox(height: 12),

                      // Single-select Range dropdown - using MultiDropdown with singleSelect: true
                      MultiDropdown<String>(
                        controller: rangeController,
                        items: ranges,
                        singleSelect:
                            true, // Changed from selectionType: SelectionType.single
                        fieldDecoration: FieldDecoration(
                          hintText: 'Диапазон',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color(0xFF8257E6),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {
                          // Selection handled by controller
                        },
                      ),
                      const SizedBox(height: 12),

                      // Single-select Mood dropdown
                      MultiDropdown<String>(
                        controller: moodController,
                        items: moods,
                        singleSelect:
                            true, // Changed from selectionType: SelectionType.single
                        fieldDecoration: FieldDecoration(
                          hintText: 'Настроение',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color(0xFF8257E6),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xFFD6C9F2),
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        dropdownDecoration: DropdownDecoration(
                          maxHeight: 200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        dropdownItemDecoration: DropdownItemDecoration(
                          selectedIcon: const Icon(
                            Icons.check,
                            color: Color(0xFF8257E6),
                          ),
                        ),
                        onSelectionChange: (selectedItems) {
                          // Selection handled by controller
                        },
                      ),

                      // Add extra space for better spacing
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
                      'categories':
                          categoriesController.selectedItems
                              .map((item) => item.label)
                              .toList(),
                      'ratings':
                          ratingsController.selectedItems
                              .map((item) => item.label)
                              .toList(),
                      'range':
                          rangeController.selectedItems.isNotEmpty
                              ? rangeController.selectedItems.first.label
                              : null,
                      'mood':
                          moodController.selectedItems.isNotEmpty
                              ? moodController.selectedItems.first.label
                              : null,
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
