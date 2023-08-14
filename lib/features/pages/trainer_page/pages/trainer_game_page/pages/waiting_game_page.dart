import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/trainer_game_page_wm.dart';

///
class WaitingGamePage extends StatelessWidget {
  ///
  final ITrainerGamePageWidgetModel wm;

  ///
  const WaitingGamePage({required this.wm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///фон
        Image.asset(
          'lib/features/pages/authorization_page/assets/images/role_background.png',
          height: wm.height,
          width: wm.width,
          fit: BoxFit.fill,
        ),

        ///размытие
        Positioned(
          bottom: 10,
          right: 1,
          left: 1,
          top: wm.height - 225,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: -8.0,
              ),
              child: Container(
                color: AppColors().primaryText.withOpacity(0),
              ),
            ),
          ),
        ),

        ///Вставлять данные
        Positioned(
          left: 16,
          right: 16,
          bottom: 135,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().white,
                  width: 0.3,
                ),
                color: const Color.fromRGBO(168, 219, 25, 0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 53),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Игра готова!'.toUpperCase(),
                          style: AppTextStyles().super_bold_23_27.copyWith(
                                color: AppColors().accentGreen,
                              ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Тренировка: Стандартная',
                          style: AppTextStyles().regular_16_21.copyWith(
                                color: AppColors().white,
                              ),
                        ),
                        Text(
                          'Уровень: 6',
                          style: AppTextStyles().regular_16_21.copyWith(
                                color: AppColors().white,
                              ),
                        ),
                        Text(
                          'Сложность: Light',
                          style: AppTextStyles().regular_16_21.copyWith(
                                color: AppColors().white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 66,
          child: Column(
            children: [
              Text(
                'Ожидание',
                style: AppTextStyles()
                    .regular_16_21
                    .copyWith(color: AppColors().white),
              ),
              const SizedBox(height: 4),
              const SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
