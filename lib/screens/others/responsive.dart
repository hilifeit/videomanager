import 'package:flutter/material.dart';

class ResponsiveMeasurement {
  factory ResponsiveMeasurement() => _instance;
  ResponsiveMeasurement._();
  static final ResponsiveMeasurement _instance = ResponsiveMeasurement._();

  double? resp(double? height, {required double? min, required double? max}) {
    if (height! < min!) {
      return min;
    } else if (height > max!) {
      return max;
    } else {
      return height;
    }
  }
}