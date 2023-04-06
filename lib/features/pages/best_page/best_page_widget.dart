import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_wm.dart';

/// Main widget for BestPage module
class BestPageWidget extends ElementaryWidget<IBestPageWidgetModel> {
  ///
  const BestPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultBestPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IBestPageWidgetModel wm) {
    return const Center(
      child: Text('Тут лучшее'),
    );
  }
}
