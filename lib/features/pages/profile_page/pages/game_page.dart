import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_wm.dart';

/// Вкладка игра
class GamePage extends StatelessWidget {
  ///
  final IProfilePageWidgetModel wm;

  ///
  const GamePage({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<GameDataLevels>(
      listenableEntityState: wm.gameData,
      loadingBuilder: (_, __) =>
          const Center(child: AdaptiveActivityIndicator()),
      builder: (_, gameData) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Уровень',
            style: AppTextStyles().bold_18_24.copyWith(
                  color: AppColors().primaryText,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int level = 1; level < 6; level++)
                EntityStateNotifierBuilder<num>(
                  listenableEntityState: wm.currentLevel,
                  builder: (_, currentLevel) => GestureDetector(
                    onTap: () {
                      if (level <= gameData!.maxLevel) {
                        wm.changeCurrentLevel(level);
                      }
                    },
                    child: Container(
                      width: 56,
                      height: 45,
                      decoration: BoxDecoration(
                        color: (level <= gameData!.maxLevel)
                            ? currentLevel != level
                                ? AppColors().primaryText
                                : AppColors().accentGreen
                            : AppColors().secondaryText,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '$level',
                          style: AppTextStyles()
                              .medium_16_21
                              .copyWith(color: AppColors().white),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int level = 6; level < 11; level++)
                EntityStateNotifierBuilder<num>(
                  listenableEntityState: wm.currentLevel,
                  builder: (_, currentLevel) => GestureDetector(
                    onTap: () {
                      if (level <= gameData!.maxLevel) {
                        wm.changeCurrentLevel(level);
                      }
                    },
                    child: Container(
                      width: 56,
                      height: 45,
                      decoration: BoxDecoration(
                        color: (level <= gameData!.maxLevel)
                            ? currentLevel != level
                                ? AppColors().primaryText
                                : AppColors().accentGreen
                            : AppColors().secondaryText,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '$level',
                          style: AppTextStyles()
                              .medium_16_21
                              .copyWith(color: AppColors().white),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Сложность',
            style: AppTextStyles().bold_18_24.copyWith(
                  color: AppColors().primaryText,
                ),
          ),
          const SizedBox(
            height: 24,
          ),
          DoubleSourceBuilder<EntityState<num>, EntityState<String>>(
            firstSource: wm.currentLevel,
            secondSource: wm.currentComplexity,
            builder: (_, currentLevel, currentComplexity) => Row(
              children: [
                GestureDetector(
                  onTap: () => wm.changeCurrentComplexity('Light'),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: currentComplexity?.data != 'Light'.toUpperCase()
                          ? AppColors().primaryText
                          : AppColors().accentGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Text(
                        'Light',
                        style: AppTextStyles()
                            .medium_14_19
                            .copyWith(color: AppColors().white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    if (gameData?.maxLevel == currentLevel?.data) {
                      if (!(gameData?.maxComplexity == 'Light'.toUpperCase())) {
                        wm.changeCurrentComplexity('Medium');
                      }
                    } else {
                      wm.changeCurrentComplexity('Medium');
                    }
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: currentComplexity?.data != 'Medium'.toUpperCase()
                          ? AppColors().primaryText
                          : AppColors().accentGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Text(
                        'Medium',
                        style: AppTextStyles()
                            .medium_14_19
                            .copyWith(color: AppColors().white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    if (gameData?.maxLevel == currentLevel?.data) {
                      if (!(gameData?.maxComplexity == 'Light'.toUpperCase()) &&
                          !(gameData?.maxComplexity ==
                              'Medium'.toUpperCase())) {
                        wm.changeCurrentComplexity('Master');
                      }
                    } else {
                      wm.changeCurrentComplexity('Master');
                    }
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: currentComplexity?.data != 'Master'.toUpperCase()
                          ? ((gameData?.maxLevel == currentLevel?.data) &&
                                  ((gameData?.maxComplexity ==
                                          'Light'.toUpperCase()) ||
                                      (gameData?.maxComplexity ==
                                          'Medium'.toUpperCase())))
                              ? AppColors().secondaryText
                              : AppColors().primaryText
                          : AppColors().accentGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Text(
                        'Master',
                        style: AppTextStyles()
                            .medium_14_19
                            .copyWith(color: AppColors().white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
