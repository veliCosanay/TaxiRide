# 🚕 TaxiRide

A modern ride-hailing application built with Flutter, featuring real-time driver tracking, dynamic pricing, and a beautiful dark-themed UI.

![Flutter](https://img.shields.io/badge/Flutter-3.9+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## ✨ Features

- 🗺️ **Real-time Map Integration** - OpenStreetMap with live driver tracking
- 📍 **GPS Location Services** - Automatic pickup location detection
- 🚗 **Multiple Ride Options** - Economy, Comfort, XL, XXL, Luxury, Bike
- ⏱️ **Live ETA Updates** - Real-time estimated time of arrival
- 💰 **Dynamic Pricing** - Distance-based fare calculation with multipliers
- 🌙 **Dark Mode UI** - Modern, sleek interface design
- 📊 **Ride Progress Tracking** - Visual progress indicator with animation

## 📱 Screenshots

| Request Ride | Driver Tracking | Ride Summary |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/cd542a81-e6e0-4eea-a678-08b938456160" width="300" /> | <img src="https://github.com/user-attachments/assets/07055920-cbd7-4f94-a3b1-22d617c53452" width="300" /> | <img src="https://github.com/user-attachments/assets/c9a1af7c-5de4-453e-bb8f-acbc836352cb" width="300" /> 
## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern:

```


lib/
├── core/
│   └── constants/          # App-wide constants
│       ├── app_colors.dart
│       ├── app_config.dart
│       ├── app_dimensions.dart
│       └── app_strings.dart
├── data/
│   ├── models/             # Data models
│   └── services/           # API services
└── presentation/
    ├── viewmodels/         # Business logic
    ├── views/              # Screen widgets
    └── widgets/            # Reusable components
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.9+
- Dart 3.0+
- Android Studio / VS Code

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_map` | OpenStreetMap integration |
| `latlong2` | Geographic coordinates handling |


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


