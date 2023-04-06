import 'package:flutter/material.dart';

/// Виджет в навигационном баре
class NavigationBarItem {
  /// Иконка в навигации
  final Widget icon;

  /// Текст в навигации
  final String label;

  /// Текст в навигации
  final bool? isTrainer;

  // final Widget? badge;

  /// Виджет в навигационном баре
  const NavigationBarItem({
    required this.icon,
    required this.label,
    this.isTrainer = false,
    // this.badge,
  });
}
