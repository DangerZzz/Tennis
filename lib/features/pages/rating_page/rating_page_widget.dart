import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_wm.dart';

/// Main widget for RatingPage module
class RatingPageWidget extends ElementaryWidget<IRatingPageWidgetModel> {
  ///
  const RatingPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultRatingPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IRatingPageWidgetModel wm) {
    return const Center(
      child: Text('Тут рейтинг'),
    );
  }
}
