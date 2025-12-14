import 'package:flutter/material.dart';

class RideOption {
  final String id;
  final String title;
  final IconData icon; // Changed from imageAsset to IconData for demo
  final double price;
  bool isSelected;

  RideOption({
    required this.id,
    required this.title,
    required this.icon,
    required this.price,
    this.isSelected = false,
  });
}
