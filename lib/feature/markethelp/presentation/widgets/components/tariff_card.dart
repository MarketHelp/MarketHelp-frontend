import 'package:flutter/material.dart';
import 'tariff_button.dart';

class TariffCard extends StatelessWidget {
  final String title;
  final List<String> features;
  final String price;
  final bool isSelected;
  final VoidCallback? onButtonPressed;

  const TariffCard({
    Key? key,
    required this.title,
    required this.features,
    required this.price,
    required this.isSelected,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Purple background color matching the image
    const Color purpleColor = Color(0xFF8559DA);

    return Container(
      decoration: BoxDecoration(
        color: purpleColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Features list with purple bullet points
          ...features.map((feature) => _buildFeatureItem(feature)),
          const SizedBox(height: 16),
          // Price and button row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Button styled like the image
              if (isSelected)
                TariffButtonFactory.createSelectedButton()
              else
                TariffButtonFactory.createChangeTariffButton(
                  onPressed: () => print('Change Tariff Pressed'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Purple bullet point as shown in the image
          Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFA389DD), // Lighter purple for bullet points
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
