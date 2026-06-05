import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQuery;
  static late double screenWidth;
  static late double screenHeight;

  static const double baseWidth = 390;
  static const double baseHeight = 844;

  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);

    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;
  }

  static double w(double width) {
    return (width / baseWidth) * screenWidth;
  }

  static double h(double height) {
    return (height / baseHeight) * screenHeight;
  }

  static double sp(double fontSize) {
    double scale = screenWidth / baseWidth;
    scale = scale.clamp(0.9, 1.15);

    return fontSize * scale;
  }

  static double r(double radius) {
    final scale = screenWidth / baseWidth;
    return radius * scale;
  }
}

extension ResponsiveExtension on num {
  double get w => Responsive.w(toDouble());

  double get h => Responsive.h(toDouble());

  double get sp => Responsive.sp(toDouble());

  double get r => Responsive.r(toDouble());
}
