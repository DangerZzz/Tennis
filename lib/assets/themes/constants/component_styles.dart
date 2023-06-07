import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';

///Цветовая схема всего приложения
class AppComponentStyles {
  final boxShadow = const [
    BoxShadow(
      color: Color.fromRGBO(238, 238, 238, 0.7),
      spreadRadius: 0.1,
      blurRadius: 20,
    ),
  ];

  final boxShadowGreen = const [
    BoxShadow(
      color: Color.fromRGBO(213, 255, 95, 1),
      spreadRadius: 0.1,
      blurRadius: 1,
    ),
  ];
  final greenGradient = LinearGradient(
    colors: [
      AppColors().gradientStart,
      AppColors().gradientEnd,
    ],
  );
  final greenGradientForCircular = LinearGradient(
    colors: [
      AppColors().gradientStart,
      AppColors().gradientStart,
      AppColors().gradientStart,
      AppColors().gradientEnd.withOpacity(0.1),
    ],
  );

  final boxBorder = Border.all(
    color: const Color.fromRGBO(238, 238, 238, 0.4),
  );
}
