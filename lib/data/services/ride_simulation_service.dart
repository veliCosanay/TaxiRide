import 'dart:math';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../core/constants/app_config.dart';
import '../models/driver.dart';
import '../models/ride_request.dart';

/// Service that simulates ride requests like a real API
class RideSimulationService {
  static final Random _random = Random();

  /// Generates a random location within Berlin center
  static LatLng generateRandomLocation() {
    final lat =
        AppConfig.defaultLatitude +
        (_random.nextDouble() * 2 - 1) * AppConfig.latitudeRange;
    final lng =
        AppConfig.defaultLongitude +
        (_random.nextDouble() * 2 - 1) * AppConfig.longitudeRange;
    return LatLng(lat, lng);
  }

  /// Generates a random location near a given point (within radius in km)
  static LatLng generateNearbyLocation(LatLng center, double radiusKm) {
    final radiusLat = radiusKm / 111.0;
    final radiusLng = radiusKm / (111.0 * cos(center.latitude * pi / 180));

    final lat = center.latitude + (_random.nextDouble() * 2 - 1) * radiusLat;
    final lng = center.longitude + (_random.nextDouble() * 2 - 1) * radiusLng;
    return LatLng(lat, lng);
  }

  /// Calculates distance between two points using Haversine formula
  static double calculateDistanceKm(LatLng from, LatLng to) {
    const Distance distance = Distance();
    return distance.as(LengthUnit.Kilometer, from, to);
  }

  /// Calculates estimated duration based on distance
  static Duration calculateETA(double distanceKm) {
    final hours = distanceKm / AppConfig.averageSpeedKmh;
    final minutes = (hours * 60).round();
    return Duration(minutes: max(1, minutes));
  }

  /// Calculates fare based on distance
  static double calculatePrice(double distanceKm, {double multiplier = 1.0}) {
    return (AppConfig.baseFareEur + distanceKm * AppConfig.perKmRateEur) *
        multiplier;
  }

  /// Generates a random driver
  static Driver generateRandomDriver() {
    final nameIndex = _random.nextInt(AppConfig.driverNames.length);
    final carIndex = _random.nextInt(AppConfig.carModels.length);
    final rating =
        AppConfig.minRating +
        _random.nextDouble() * (AppConfig.maxRating - AppConfig.minRating);

    final letters = String.fromCharCodes([
      65 + _random.nextInt(26),
      65 + _random.nextInt(26),
    ]);
    final numbers = 1000 + _random.nextInt(9000);

    return Driver(
      id: 'd${_random.nextInt(10000)}',
      name: AppConfig.driverNames[nameIndex],
      carModel: AppConfig.carModels[carIndex],
      licensePlate: '${AppConfig.licensePlatePrefix}-$letters $numbers',
      rating: double.parse(rating.toStringAsFixed(1)),
      avatarIcon: Icons.person,
    );
  }

  /// Creates a complete ride request with all random data
  static RideRequest createRideRequest({double priceMultiplier = 1.0}) {
    final pickupLocation = generateRandomLocation();
    final destinationLocation = generateRandomLocation();

    final driverDistance =
        AppConfig.minDriverDistance +
        _random.nextDouble() *
            (AppConfig.maxDriverDistance - AppConfig.minDriverDistance);
    final driverLocation = generateNearbyLocation(
      pickupLocation,
      driverDistance,
    );

    final rideDistanceKm = calculateDistanceKm(
      pickupLocation,
      destinationLocation,
    );
    final driverToPickupKm = calculateDistanceKm(
      driverLocation,
      pickupLocation,
    );

    final driver = generateRandomDriver();
    final eta = calculateETA(driverToPickupKm);
    final price = calculatePrice(rideDistanceKm, multiplier: priceMultiplier);

    return RideRequest(
      id: 'ride_${DateTime.now().millisecondsSinceEpoch}',
      pickupLocation: pickupLocation,
      destinationLocation: destinationLocation,
      driverLocation: driverLocation,
      driver: driver,
      distanceKm: rideDistanceKm,
      estimatedDuration: eta,
      price: price,
      requestTime: DateTime.now(),
    );
  }

  /// Interpolates position between two points based on progress (0.0 to 1.0)
  static LatLng interpolatePosition(LatLng from, LatLng to, double progress) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final lat = from.latitude + (to.latitude - from.latitude) * clampedProgress;
    final lng =
        from.longitude + (to.longitude - from.longitude) * clampedProgress;
    return LatLng(lat, lng);
  }
}
