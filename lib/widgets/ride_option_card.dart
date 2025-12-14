import 'package:flutter/material.dart';
import '../models/ride_option.dart';

class RideOptionCard extends StatelessWidget {
  final RideOption option;
  final VoidCallback onTap;

  const RideOptionCard({super.key, required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine if we should highlight this card
    final isSelected = option.isSelected;
    final textColor = isSelected ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100, // Fixed width for horizontal list items
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Color(0xFF1E1E1E), // Dark card bg
          borderRadius: BorderRadius.circular(16.0),
          border: isSelected ? Border.all(color: Colors.amber, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              option.icon,
              size: 40,
              color: isSelected ? Colors.black : Colors.white70,
            ),
            const SizedBox(height: 12),
            Text(
              option.title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            // Price is not shown in the card in the design, checking design...
            // Design shows just Car Image + "Economy" title.
            // Wait, looking closer at the screenshot:
            // The cards show Car Image + "Economy" / "Comfort" / "XL"
            // The price is not explicitly in the small cards, but maybe?
            // Actually they look like buttons.
            // I'll stick to Image + Title for now matching the list in the screenshot.
          ],
        ),
      ),
    );
  }
}
