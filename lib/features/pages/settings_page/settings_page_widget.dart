import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_wm.dart';

/// Main widget for SettingsPage module
class SettingsPageWidget extends ElementaryWidget<ISettingsPageWidgetModel> {
  ///
  const SettingsPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultSettingsPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingsPageWidgetModel wm) {
    return const Center(
      child: Text('Тут настройки'),
    );
  }
}
