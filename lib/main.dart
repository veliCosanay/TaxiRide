import 'package:flutter/material.dart';
import 'views/ride_screen.dart';
import 'viewmodels/ride_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the ViewModel here (or using a DI container/Provider in larger apps)
    final rideViewModel = RideViewModel();

    return MaterialApp(
      title: 'Taxi Ride Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark, // Dark theme as per design
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black, // Ensure background is black
      ),
      home: RideScreen(viewModel: rideViewModel),
    );
  }
}
