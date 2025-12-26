import 'package:flutter/material.dart';

/// All color constants used in the app
abstract class AppColors {
  // Primary colors
  static const Color primary = Colors.amber;
  static const Color primaryDark = Color(0xFFFFA000);

  // Background colors
  static const Color background = Colors.black;
  static const Color cardBackground = Color(0xFF1E1E1E);
  static const Color cardBackgroundLight = Color(0xFF2C2C2C);

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textOnPrimary = Colors.black;

  // Status colors
  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;

  // Map marker colors
  static const Color markerTaxi = Colors.amber;
  static const Color markerPickup = Colors.blue;
  static const Color markerDestination = Colors.green;
}
