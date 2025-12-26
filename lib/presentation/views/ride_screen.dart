import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../viewmodels/ride_viewmodel.dart';
import '../widgets/ride_option_card.dart';
import '../widgets/map_widget.dart';
import 'ride_status_screen.dart';

class RideScreen extends StatelessWidget {
  final RideViewModel viewModel;

  const RideScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final markers = <Marker>[
          Marker(
            point: viewModel.pickupLocation,
            width: AppDimensions.mapMarkerSize,
            height: AppDimensions.mapMarkerSize,
            child: Icon(
              Icons.location_on,
              color: AppColors.primary,
              size: AppDimensions.mapMarkerSize,
            ),
          ),
        ];

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Top Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                    vertical: AppDimensions.paddingM,
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.rideTitle,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppDimensions.fontSizeTitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => viewModel.refreshPickupLocation(),
                        icon: Icon(Icons.refresh, color: AppColors.primary),
                        tooltip: AppStrings.refreshLocation,
                      ),
                    ],
                  ),
                ),

                // Map Area
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppDimensions.marginM,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusXXL,
                      ),
                    ),
                    child: MapWidget(
                      initialPosition: viewModel.pickupLocation,
                      initialZoom: 15.0,
                      markers: markers,
                      isDarkMode: false,
                    ),
                  ),
                ),

                SizedBox(height: AppDimensions.paddingM + 4),

                // Pickup Location Title
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.pickupLocation,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppDimensions.fontSizeXXL,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppDimensions.paddingM),

                // Ride Options List
                SizedBox(
                  height: AppDimensions.rideOptionCardHeight,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.marginM,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.rideOptions.length,
                    itemBuilder: (context, index) {
                      final option = viewModel.rideOptions[index];
                      return RideOptionCard(
                        option: option,
                        onTap: () => viewModel.selectRide(option),
                      );
                    },
                  ),
                ),

                SizedBox(height: AppDimensions.paddingM),

                // Category Tabs
                SizedBox(
                  height: AppDimensions.categoryTabHeight,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.marginM,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.rideCategories.length,
                    itemBuilder: (context, index) {
                      final category = viewModel.rideCategories[index];
                      return GestureDetector(
                        onTap: () => viewModel.selectCategory(category),
                        child: _buildTextTab(
                          category.title,
                          category.isSelected,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: AppDimensions.paddingL),

                // Request Button
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
                        final rideRequest = viewModel.requestRide();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                RideStatusScreen(rideRequest: rideRequest),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textOnPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusL,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppStrings.requestRide,
                        style: TextStyle(
                          fontSize: AppDimensions.fontSizeXL,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextTab(String text, bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: AppDimensions.marginS + 4),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM + 4,
        vertical: AppDimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? AppColors.textOnPrimary : AppColors.textSecondary,
          fontSize: AppDimensions.fontSizeM,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
