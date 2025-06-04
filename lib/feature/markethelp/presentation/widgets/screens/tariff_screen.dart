import 'package:flutter/material.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';
import '../components/tariff_card.dart';

class TariffScreen extends StatelessWidget {
  const TariffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        screenTitle: "Тарифы",
        withSettings: false,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TariffCard(
              title: 'Базовый тариф',
              features: const [
                'Интеграция с Яндекс Маркет',
                'Анализ отзывов и генерация инфографики',
                'AI-советы по улучшению товара',
                'Ограниченное количество запросов',
                'Водяной знак на инфографике',
              ],
              price: 'Бесплатно',
              isSelected: true,
              onButtonPressed: () {
                // This will be handled by the BLoC
              },
            ),
            SizedBox(height: 16),
            TariffCard(
              title: 'Продвинутый тариф',
              features: [
                'Все возможности базового тарифа',
                'Удаление водяного знака с инфографики',
                'Неограниченное количество запросов',
              ],
              price: '1000 ₽/месяц',
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }
}
