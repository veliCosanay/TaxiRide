import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../core/constants/app_config.dart';
import '../../data/models/ride_option.dart';
import '../../data/models/ride_request.dart';
import '../../data/services/ride_simulation_service.dart';

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

  List<RideCategory> _rideCategories = [];
  RideCategory? _selectedCategory;

  LatLng _pickupLocation = LatLng(
    AppConfig.defaultLatitude,
    AppConfig.defaultLongitude,
  );

  List<RideOption> get rideOptions => _rideOptions;
  RideOption? get selectedOption => _selectedOption;

  List<RideCategory> get rideCategories => _rideCategories;
  RideCategory? get selectedCategory => _selectedCategory;

  LatLng get pickupLocation => _pickupLocation;

  RideViewModel() {
    _loadData();
  }

  void _loadData() {
    _pickupLocation = RideSimulationService.generateRandomLocation();

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

    _rideCategories = [
      RideCategory(id: 'c1', title: 'Economy'),
      RideCategory(id: 'c2', title: 'Comfort'),
      RideCategory(id: 'c3', title: 'XL'),
      RideCategory(id: 'c4', title: 'XXL'),
      RideCategory(id: 'c5', title: 'Luxury'),
      RideCategory(id: 'c6', title: 'Electric'),
    ];

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

  double _getPriceMultiplier() {
    switch (_selectedOption?.id) {
      case '1':
        return AppConfig.economyMultiplier;
      case '2':
        return AppConfig.comfortMultiplier;
      case '3':
        return AppConfig.xlMultiplier;
      case '4':
        return AppConfig.xxlMultiplier;
      case '5':
        return AppConfig.luxuryMultiplier;
      case '6':
        return AppConfig.bikeMultiplier;
      default:
        return AppConfig.economyMultiplier;
    }
  }

  RideRequest requestRide() {
    return RideSimulationService.createRideRequest(
      priceMultiplier: _getPriceMultiplier(),
    );
  }

  void refreshPickupLocation() {
    _pickupLocation = RideSimulationService.generateRandomLocation();
    notifyListeners();
  }
}
