import 'package:flutter/material.dart';
import 'dart:math'; // Import for random
import '../models/ride_option.dart';
import '../models/driver.dart';

class RideCategory {
  final String id;
  final String title;
  bool isSelected;

  RideCategory({
    required this.id,
    required this.title,
    this.isSelected = false,
  });
}

class RideViewModel extends ChangeNotifier {
  List<RideOption> _rideOptions = [];
  RideOption? _selectedOption;

  // New independent category list
  List<RideCategory> _rideCategories = [];
  RideCategory? _selectedCategory;

  List<RideOption> get rideOptions => _rideOptions;
  RideOption? get selectedOption => _selectedOption;

  List<RideCategory> get rideCategories => _rideCategories;
  RideCategory? get selectedCategory => _selectedCategory;

  RideViewModel() {
    _loadData();
  }

  void _loadData() {
    // 1. Load Ride Options (Main Cards)
    _rideOptions = [
      RideOption(
        id: '1',
        title: 'Economy',
        icon: Icons.directions_car,
        price: 10.50,
      ),
      RideOption(
        id: '2',
        title: 'Comfort',
        icon: Icons.local_taxi,
        price: 15.20,
      ),
      RideOption(
        id: '3',
        title: 'XL',
        icon: Icons.airport_shuttle,
        price: 22.50,
      ),
      // Added more options to demonstrate horizontal scrolling "slider" effect
      RideOption(
        id: '4',
        title: 'XXL',
        icon: Icons.directions_bus,
        price: 35.00,
      ),
      RideOption(id: '5', title: 'Luxury', icon: Icons.diamond, price: 45.50),
      RideOption(id: '6', title: 'Bike', icon: Icons.pedal_bike, price: 5.00),
    ];

    if (_rideOptions.isNotEmpty) {
      selectRide(_rideOptions.first);
    }

    // 2. Load Ride Categories (Bottom Text List) - Independent
    _rideCategories = [
      RideCategory(id: 'c1', title: 'Economy'),
      RideCategory(id: 'c2', title: 'Comfort'),
      RideCategory(id: 'c3', title: 'XL'),
      RideCategory(id: 'c4', title: 'XXL'), // Added for testing scroll
      RideCategory(id: 'c5', title: 'Luxury'),
      RideCategory(id: 'c6', title: 'Electric'),
    ];

    // Select first category by default
    if (_rideCategories.isNotEmpty) {
      selectCategory(_rideCategories.first);
    }

    notifyListeners();
  }

  void selectRide(RideOption option) {
    for (var op in _rideOptions) {
      op.isSelected = (op.id == option.id);
    }
    _selectedOption = option;
    notifyListeners();
  }

  void selectCategory(RideCategory category) {
    for (var cat in _rideCategories) {
      cat.isSelected = (cat.id == category.id);
    }
    _selectedCategory = category;
    notifyListeners();
  }

  // Simulate requesting a ride and getting a driver assigned
  Driver requestRide() {
    // Dummy data based on the design image
    return Driver(
      id: 'd1',
      name: 'Ryan Webb',
      carModel: 'Tesla Model S',
      licensePlate: '46C1234',
      rating: 4.8,
      avatarIcon: Icons.person_pin, // Placeholder
    );
  }

  // Generate a random price for the final summary
  double generateFinalPrice() {
    final random = Random();
    // Random price between 15.00 and 50.00
    return 15.0 + random.nextDouble() * 35.0;
  }
}
