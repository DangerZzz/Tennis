import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_wm.dart';

/// Main widget for UsefulPage module
class UsefulPageWidget extends ElementaryWidget<IUsefulPageWidgetModel> {
  ///
  const UsefulPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultUsefulPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IUsefulPageWidgetModel wm) {
    return const Center(
      child: Text('Тут полезное'),
    );
  }
}
