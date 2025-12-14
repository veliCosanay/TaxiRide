import 'package:flutter/material.dart';
import '../models/driver.dart';
import '../models/ride_option.dart';
import '../viewmodels/ride_viewmodel.dart';
import 'ride_summary_screen.dart';

class RideStatusScreen extends StatelessWidget {
  final Driver driver;
  final RideOption? rideOption;

  const RideStatusScreen({
    super.key,
    required this.driver,
    required this.rideOption,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button and Time
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.amber),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    '12:01', // Static time per design request
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(width: 48), // Balance for back button
                ],
              ),
            ),

            // Map Area with Car Path (Placeholder)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Stack(
                  children: [
                    // Dark Map Background
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.map,
                          size: 64,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                    // Route Path (Mock)
                    // Just a visual representation
                    Center(
                      child: CustomPaint(
                        size: Size(200, 200),
                        painter: RoutePainter(),
                      ),
                    ),

                    // Car Icon on Path
                    Center(
                      child: Icon(
                        Icons.directions_car,
                        color: Colors.grey[400],
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Driver Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[700],
                      child: Icon(driver.avatarIcon, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${driver.carModel} • ${driver.licensePlate}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Rating visual could go here, omitting for simplicity/cleanliness as not explicitly detailed in instruction beyond "2. screen"
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ETA Display
            Text(
              '3:20 pm', // Static dummy time per design
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Bottom Info Panel
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            driver.name.split(' ').first, // Just First Name?
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '3:20 pm',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Complete Ride Button (Added for Demo Flow)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // Generate random price via VM (instantiating local instance for simplicity or passing it)
                        // For this simple demo, I'll instantiate or just use the random logic here if needed,
                        // but ideally we pass the VM.
                        // To keep it simple without large refactor to pass VM everywhere:
                        final mockPrice = RideViewModel().generateFinalPrice();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                RideSummaryScreen(price: mockPrice),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Arrived / Complete Ride',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// Simple Painter to draw a mocked curved route line
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.75,
      size.width * 0.7,
      size.height * 0.8,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
