import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/fade_indexed_stack.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/main_settings_page.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page.dart';
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors().white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors().white,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: wm.onBack,
            child: Icon(
              TennisIcons.back,
              color: AppColors().primaryText,
              size: 12,
            ),
          ),
          title: Text(
            'Настройки',
            style: AppTextStyles().bold_24_32.copyWith(
                  color: AppColors().primaryText,
                ),
          ),
        ),
        body: EntityStateNotifierBuilder<int>(
          listenableEntityState: wm.index,
          builder: (_, index) => FadeIndexedStack(
            index: index!.toInt(),
            children: [
              MainSettingsPage(wm: wm),
              AvatarsPage(wm: wm),
              NameEditPage(wm: wm),
              CharacteristicsPage(wm: wm),
            ],
          ),
        ),
      ),
    );
  }
}
