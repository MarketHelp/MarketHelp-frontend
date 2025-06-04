import 'package:flutter/material.dart';

class TariffButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  const TariffButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSelected ? null : onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFF8559DA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? const Color(0xFF8559DA) : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.check,
                size: 16,
                color: isSelected ? const Color(0xFF8559DA) : Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Factory class to create different styles of tariff buttons
class TariffButtonFactory {
  /// Creates a "Change Tariff" button with purple background
  static Widget createChangeTariffButton({required VoidCallback onPressed}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0x7D52D9FF), // Semi-transparent purple
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Сменить тариф',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a "Selected" button with checkmark
  static Widget createSelectedButton() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF8559DA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Выбрано',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.check, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }

  /// Creates a tariff button based on selection state
  static Widget createTariffButton({
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return isSelected
        ? createSelectedButton()
        : createChangeTariffButton(onPressed: onPressed);
  }
}
