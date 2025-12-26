import 'package:latlong2/latlong.dart';
import 'driver.dart';

/// Represents a complete ride request with all location and timing data
class RideRequest {
  final String id;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final LatLng driverLocation;
  final Driver driver;
  final double distanceKm;
  final Duration estimatedDuration;
  final double price;
  final DateTime requestTime;

  RideRequest({
    required this.id,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.driverLocation,
    required this.driver,
    required this.distanceKm,
    required this.estimatedDuration,
    required this.price,
    required this.requestTime,
  });

  /// Returns time until arrival in minutes
  int get etaMinutes => estimatedDuration.inMinutes;

  /// Returns formatted ETA string
  String get etaFormatted {
    final minutes = estimatedDuration.inMinutes;
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '${hours}h ${mins}min';
    }
  }

  /// Returns formatted distance
  String get distanceFormatted {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).toInt()} m';
    }
    return '${distanceKm.toStringAsFixed(1)} km';
  }
}
