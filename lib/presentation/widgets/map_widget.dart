import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/constants/app_dimensions.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;
  final double initialZoom;
  final List<Marker>? markers;
  final bool isDarkMode;

  const MapWidget({
    super.key,
    required this.initialPosition,
    this.initialZoom = 14.0,
    this.markers,
    this.isDarkMode = true,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: widget.initialPosition,
          initialZoom: widget.initialZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: widget.isDarkMode
                ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c', 'd'],
            userAgentPackageName: 'com.example.taxi_ride',
          ),
          if (widget.markers != null && widget.markers!.isNotEmpty)
            MarkerLayer(markers: widget.markers!),
        ],
      ),
    );
  }
}
