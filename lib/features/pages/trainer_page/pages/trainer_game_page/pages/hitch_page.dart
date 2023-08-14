import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/trainer_game_page_wm.dart';

///
class HitchTrainerPage extends StatelessWidget {
  ///
  final ITrainerGamePageWidgetModel wm;

  ///
  const HitchTrainerPage({required this.wm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Заминка',
              style: AppTextStyles().bold_24_32.copyWith(
                    color: AppColors().primaryText,
                  ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              width: wm.width,
              decoration: BoxDecoration(
                color: AppColors().accentGreen,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().white,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 3,
                      ),
                      child: EntityStateNotifierBuilder<int>(
                        listenableEntityState: wm.countdownTime,
                        builder: (_, countdownTime) => Text(
                          wm.countdown(countdownTime!),
                          style: AppTextStyles().bold_20_27.copyWith(
                                color: AppColors().accentGreen,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  EntityStateNotifierBuilder<String>(
                    listenableEntityState: wm.warmUpType,
                    builder: (_, warmUpType) => Text(
                      warmUpType?.toUpperCase() ?? '',
                      style: AppTextStyles().bold_24_32.copyWith(
                            color: AppColors().white,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Text(
                      'Бег на комфортной скорости с последующим переходом в шаг',
                      style: AppTextStyles().semibold_18_21.copyWith(
                            color: AppColors().white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 53,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 42, right: 16.0),
                    child: Image.asset(
                      'lib/features/pages/game_page/pages/new_game_pages/assets/images/hitch.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
