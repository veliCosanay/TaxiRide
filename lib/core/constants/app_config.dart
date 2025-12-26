/// Configuration constants for simulation and API-like behavior
abstract class AppConfig {
  // Berlin center coordinates (Mitte area)
  static const double defaultLatitude = 52.5200;
  static const double defaultLongitude = 13.4050;
  static const double latitudeRange = 0.03;
  static const double longitudeRange = 0.04;

  // Map settings
  static const double defaultMapZoom = 14.0;
  static const double pickupMapZoom = 15.0;

  // Simulation settings
  static const double averageSpeedKmh = 25.0;
  static const double baseFareEur = 3.90;
  static const double perKmRateEur = 2.0;
  static const int simulationUpdateIntervalMs = 2000;
  static const double progressIncrementPerTick = 0.1;

  // Driver distance range (km)
  static const double minDriverDistance = 0.5;
  static const double maxDriverDistance = 2.0;

  // Rating range
  static const double minRating = 4.0;
  static const double maxRating = 5.0;

  // Price multipliers for ride types
  static const double economyMultiplier = 1.0;
  static const double comfortMultiplier = 1.3;
  static const double xlMultiplier = 1.6;
  static const double xxlMultiplier = 2.0;
  static const double luxuryMultiplier = 2.5;
  static const double bikeMultiplier = 0.5;

  // Driver names pool (German)
  static const List<String> driverNames = [
    'Hans Müller',
    'Klaus Schmidt',
    'Peter Weber',
    'Thomas Fischer',
    'Michael Wagner',
    'Stefan Becker',
    'Andreas Hoffmann',
    'Markus Schäfer',
    'Jürgen Koch',
    'Wolfgang Richter',
  ];

  // Car models pool
  static const List<String> carModels = [
    'Mercedes E-Class',
    'BMW 5 Series',
    'Volkswagen Passat',
    'Audi A4',
    'Mercedes C-Class',
    'BMW 3 Series',
    'Volkswagen Golf',
    'Opel Insignia',
    'Skoda Superb',
    'Tesla Model 3',
  ];

  // License plate prefix (Berlin)
  static const String licensePlatePrefix = 'B';
}
