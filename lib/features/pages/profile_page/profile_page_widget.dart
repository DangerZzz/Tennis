import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_wm.dart';

/// Main widget for ProfilePage module
class ProfilePageWidget extends ElementaryWidget<IProfilePageWidgetModel> {
  ///
  const ProfilePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultProfilePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IProfilePageWidgetModel wm) {
    return const Center(
      child: Text('Тут профиль'),
    );
  }
}
