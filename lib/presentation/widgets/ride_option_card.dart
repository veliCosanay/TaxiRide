import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_config.dart';
import '../../core/constants/app_dimensions.dart';
import '../../data/models/ride_option.dart';

class RideOptionCard extends StatelessWidget {
  final RideOption option;
  final VoidCallback onTap;

  const RideOptionCard({super.key, required this.option, required this.onTap});

  String _getMultiplierText() {
    switch (option.id) {
      case '1':
        return '${AppConfig.economyMultiplier}x';
      case '2':
        return '${AppConfig.comfortMultiplier}x';
      case '3':
        return '${AppConfig.xlMultiplier}x';
      case '4':
        return '${AppConfig.xxlMultiplier}x';
      case '5':
        return '${AppConfig.luxuryMultiplier}x';
      case '6':
        return '${AppConfig.bikeMultiplier}x';
      default:
        return '${AppConfig.economyMultiplier}x';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = option.isSelected;
    final textColor = isSelected
        ? AppColors.textOnPrimary
        : AppColors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimensions.rideOptionCardWidth,
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.marginS),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
          boxShadow: const [
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
              size: AppDimensions.iconL,
              color: isSelected
                  ? AppColors.textOnPrimary
                  : AppColors.textSecondary,
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              option.title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.fontSizeM - 1,
              ),
            ),
            SizedBox(height: AppDimensions.paddingXS),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.black.withValues(alpha: 0.2)
                    : AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Text(
                _getMultiplierText(),
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textOnPrimary
                      : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.fontSizeXS,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
