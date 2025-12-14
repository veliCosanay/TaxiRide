import 'package:flutter/material.dart';

class Driver {
  final String id;
  final String name;
  final String carModel;
  final String licensePlate;
  final double rating;
  final IconData avatarIcon; // Using Icon for simplicity per plan

  Driver({
    required this.id,
    required this.name,
    required this.carModel,
    required this.licensePlate,
    required this.rating,
    this.avatarIcon = Icons.person,
  });
}
