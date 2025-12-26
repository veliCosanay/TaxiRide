import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_config.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/ride_request.dart';
import '../../data/services/ride_simulation_service.dart';
import '../widgets/map_widget.dart';
import 'ride_summary_screen.dart';

class RideStatusScreen extends StatefulWidget {
  final RideRequest rideRequest;

  const RideStatusScreen({super.key, required this.rideRequest});

  @override
  State<RideStatusScreen> createState() => _RideStatusScreenState();
}

class _RideStatusScreenState extends State<RideStatusScreen> {
  late LatLng _currentDriverLocation;
  late Duration _remainingTime;
  late double _progress;
  Timer? _progressTimer;
  bool _rideStarted = false;

  @override
  void initState() {
    super.initState();
    _currentDriverLocation = widget.rideRequest.driverLocation;
    _remainingTime = widget.rideRequest.estimatedDuration;
    _progress = 0.0;
    _startSimulation();
  }

  void _startSimulation() {
    _progressTimer = Timer.periodic(
      Duration(milliseconds: AppConfig.simulationUpdateIntervalMs),
      (timer) {
        setState(() {
          if (!_rideStarted) {
            _progress += AppConfig.progressIncrementPerTick;

            if (_progress >= 1.0) {
              _progress = 1.0;
              _rideStarted = true;
              _currentDriverLocation = widget.rideRequest.pickupLocation;
            } else {
              _currentDriverLocation =
                  RideSimulationService.interpolatePosition(
                    widget.rideRequest.driverLocation,
                    widget.rideRequest.pickupLocation,
                    _progress,
                  );
            }

            final decreaseSeconds =
                (widget.rideRequest.estimatedDuration.inSeconds *
                        AppConfig.progressIncrementPerTick)
                    .round();
            final newSeconds = _remainingTime.inSeconds - decreaseSeconds;
            _remainingTime = Duration(seconds: newSeconds > 0 ? newSeconds : 0);
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    if (minutes > 0) {
      return '$minutes ${AppStrings.minuteAbbr} $seconds ${AppStrings.secondAbbr}';
    }
    return '$seconds ${AppStrings.secondAbbr}';
  }

  @override
  Widget build(BuildContext context) {
    final driver = widget.rideRequest.driver;

    final markers = <Marker>[
      Marker(
        point: _currentDriverLocation,
        width: AppDimensions.mapMarkerSizeLarge,
        height: AppDimensions.mapMarkerSizeLarge,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(255, 193, 7, 0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.local_taxi,
            color: AppColors.textOnPrimary,
            size: 30,
          ),
        ),
      ),
      Marker(
        point: widget.rideRequest.pickupLocation,
        width: AppDimensions.mapMarkerSize,
        height: AppDimensions.mapMarkerSize,
        child: Icon(
          Icons.person_pin_circle,
          color: AppColors.markerPickup,
          size: AppDimensions.mapMarkerSize,
        ),
      ),
      Marker(
        point: widget.rideRequest.destinationLocation,
        width: AppDimensions.mapMarkerSize,
        height: AppDimensions.mapMarkerSize,
        child: Icon(Icons.flag, color: AppColors.markerDestination, size: 36),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingM,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.primary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    _rideStarted
                        ? AppStrings.driverArrived
                        : AppStrings.driverOnTheWay,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimensions.fontSizeL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: AppDimensions.iconXXL),
                ],
              ),
            ),

            // Map
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.marginM),
                child: MapWidget(
                  initialPosition: _currentDriverLocation,
                  initialZoom: AppConfig.defaultMapZoom,
                  markers: markers,
                  isDarkMode: true,
                ),
              ),
            ),

            SizedBox(height: AppDimensions.paddingM),

            // Progress indicator
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.progress,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppDimensions.fontSizeM,
                        ),
                      ),
                      Text(
                        '${(_progress * 100).toInt()}%',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: AppDimensions.fontSizeM,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: AppColors.cardBackgroundLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimensions.paddingM),

            // Driver Info Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: Container(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: AppDimensions.avatarRadiusLarge,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        driver.name.split(' ').map((e) => e[0]).join(),
                        style: TextStyle(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.fontSizeXL,
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driver.name,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppDimensions.fontSizeXL,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppDimensions.paddingXS),
                          Text(
                            driver.carModel,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppDimensions.fontSizeM,
                            ),
                          ),
                          Text(
                            driver.licensePlate,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: AppDimensions.fontSizeM,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 193, 7, 0.2),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusM,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.primary,
                            size: AppDimensions.iconS,
                          ),
                          SizedBox(width: AppDimensions.paddingXS),
                          Text(
                            driver.rating.toString(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppDimensions.paddingM),

            // ETA and Distance info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: Container(
                padding: EdgeInsets.all(AppDimensions.paddingM + 4),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoItem(
                          icon: Icons.access_time,
                          label: AppStrings.timeLeft,
                          value: _formatTime(_remainingTime),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: AppColors.cardBackgroundLight,
                        ),
                        _buildInfoItem(
                          icon: Icons.route,
                          label: AppStrings.distance,
                          value: widget.rideRequest.distanceFormatted,
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: AppColors.cardBackgroundLight,
                        ),
                        _buildInfoItem(
                          icon: Icons.attach_money,
                          label: AppStrings.fare,
                          value:
                              '${AppStrings.currency}${widget.rideRequest.price.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.paddingM + 4),
                    SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeightSmall,
                      child: ElevatedButton(
                        onPressed: _rideStarted
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RideSummaryScreen(
                                      price: widget.rideRequest.price,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textOnPrimary,
                          disabledBackgroundColor:
                              AppColors.cardBackgroundLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusM,
                            ),
                          ),
                        ),
                        child: Text(
                          _rideStarted
                              ? AppStrings.completeRide
                              : AppStrings.waitingForDriver,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: AppDimensions.iconM),
        SizedBox(height: AppDimensions.paddingS),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppDimensions.fontSizeS,
          ),
        ),
        SizedBox(height: AppDimensions.paddingXS),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimensions.fontSizeL,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
