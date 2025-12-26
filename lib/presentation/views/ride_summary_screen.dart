import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class RideSummaryScreen extends StatelessWidget {
  final double price;

  const RideSummaryScreen({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingM,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: AppDimensions.iconXXL),
                  Text(
                    '441',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimensions.fontSizeL,
                    ),
                  ),
                  SizedBox(width: AppDimensions.iconXXL),
                ],
              ),
            ),

            SizedBox(height: AppDimensions.paddingM + 4),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.rideTitle,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppDimensions.fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Summary',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppDimensions.fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppDimensions.paddingXL + 8),

            // Main Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.marginL),
              padding: EdgeInsets.all(AppDimensions.paddingL),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
              ),
              child: Column(
                children: [
                  Text(
                    '${AppStrings.currency}${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimensions.fontSizePrice,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSummaryRow(AppStrings.total, price.toStringAsFixed(2)),
                  SizedBox(height: AppDimensions.marginS + 4),
                  Divider(color: AppColors.textSecondary),
                  SizedBox(height: AppDimensions.marginS + 4),
                  _buildSummaryRow(
                    AppStrings.ride,
                    (price * 0.8).toStringAsFixed(2),
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                  _buildSummaryRow(
                    AppStrings.tax,
                    (price * 0.2).toStringAsFixed(2),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Payment Method
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.marginL),
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM + 4,
                vertical: AppDimensions.paddingM,
              ),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              ),
              child: Row(
                children: [
                  Text(
                    'VISA',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.fontSizeXL,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '**** 1234',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimensions.paddingL),

            // Pay Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
                vertical: AppDimensions.paddingM,
              ),
              child: SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardBackground,
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusL,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.payAndFinish,
                    style: TextStyle(
                      fontSize: AppDimensions.fontSizeXL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppDimensions.fontSizeL,
          ),
        ),
        Text(
          '${AppStrings.currency}$value',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimensions.fontSizeL,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
