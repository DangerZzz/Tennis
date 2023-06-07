import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_wm.dart';

///
class HitchPage extends StatelessWidget {
  ///
  final INewGamePageWidgetModel wm;

  ///
  const HitchPage({required this.wm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Заминка',
                  style: AppTextStyles().bold_24_32.copyWith(
                        color: AppColors().primaryText,
                      ),
                ),
                GestureDetector(
                  // onTap: widgetModel.onBackWithIndex,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: AppColors().primaryText,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Icon(
                        TennisIcons.x,
                        color: AppColors().white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
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
                  Text(
                    'Бег по кругу'.toUpperCase(),
                    style: AppTextStyles().bold_24_32.copyWith(
                          color: AppColors().white,
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
