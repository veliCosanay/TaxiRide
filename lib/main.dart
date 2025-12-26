import 'package:flutter/material.dart';
import 'presentation/views/ride_screen.dart';
import 'presentation/viewmodels/ride_viewmodel.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final rideViewModel = RideViewModel();

    return MaterialApp(
      title: 'Taxi Ride',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: RideScreen(viewModel: rideViewModel),
    );
  }
}
