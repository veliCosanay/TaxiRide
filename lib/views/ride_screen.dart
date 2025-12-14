import 'package:flutter/material.dart';
import '../viewmodels/ride_viewmodel.dart';
import '../widgets/ride_option_card.dart';
import 'ride_status_screen.dart';

class RideScreen extends StatelessWidget {
  final RideViewModel viewModel;

  const RideScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  const Text(
                    'Ride',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  // Indicators (Wifi/Cell) are part of system status bar,
                  // but in design they are white. SafeArea handles avoiding notch.
                ],
              ),
            ),

            // Map Area (Placeholder)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Stack(
                    children: [
                      // Placeholder Map Background
                      Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(
                            Icons.map,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      // Mock Map Visuals (Grid lines etc would go here)

                      // Marker
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.amber,
                            size: 48,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pickup Location Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pickup Location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ride Options List
            SizedBox(
              height: 110,
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.rideOptions.length,
                    itemBuilder: (context, index) {
                      final option = viewModel.rideOptions[index];
                      return RideOptionCard(
                        option: option,
                        onTap: () => viewModel.selectRide(option),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Additional Ride Details (Optional, matching design bottom text tabs)
            // Just duplicating the selector style as placeholders essentially
            // Secondary Ride Options List (Text Tabs) - Scrollable
            SizedBox(
              height: 40,
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Request Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // 1. Get dummy driver data from ViewModel
                    final driver = viewModel.requestRide();

                    // 2. Navigate to Status Screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RideStatusScreen(
                          driver: driver,
                          rideOption: viewModel.selectedOption,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Request Ride',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextTab(String text, bool isActive) {
    // Small text tabs below the image cards in the design
    // Actually looking closely at design, the things below the image cards
    // look like a replica of the selection or maybe different service levels.
    // I will just implement them as styled text containers.
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.amber : Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20), // More rounded for tabs
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.black : Colors.white70,
          fontSize: 14,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
