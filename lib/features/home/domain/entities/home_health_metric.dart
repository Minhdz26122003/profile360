import 'package:flutter/material.dart';

class HomeHealthMetric {
  const HomeHealthMetric({
    required this.label,
    required this.icon,
    required this.value,
    this.status,
    this.statusColor,
    this.barColor,
    this.barValue,
  });

  final String label;
  final String icon;
  final String value;
  final String? status;
  final Color? statusColor;
  final Color? barColor;
  final double? barValue;
}
