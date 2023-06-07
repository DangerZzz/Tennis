import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/pages/statistics_page.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/pages/workout_information_page.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/statistics_in_game_wm.dart';

/// Main widget for StatisticsInGame module
class StatisticsInGameWidget
    extends ElementaryWidget<IStatisticsInGameWidgetModel> {
  ///
  const StatisticsInGameWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultStatisticsInGameWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IStatisticsInGameWidgetModel wm) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors().white,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: AppColors().white,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            shadowColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16,
                bottom: 32,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: wm.back,
                    child: Icon(
                      TennisIcons.back,
                      color: AppColors().primaryText,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'Статистика',
                    style: AppTextStyles().bold_24_32.copyWith(
                          color: AppColors().primaryText,
                        ),
                  ),
                ],
              ),
            ),
          ),
          body: EntityStateNotifierBuilder<int>(
            listenableEntityState: wm.index,
            builder: (_, index) => index == 0
                ? StatisticsPageInGame(wm: wm)
                : WorkoutInformationPage(wm: wm),
          ),
        ),
      ),
    );
  }
}
