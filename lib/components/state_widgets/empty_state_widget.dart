import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';

/// Виджет, отображающийся при загрузке пустой страницы
class EmptyStateWidget extends StatelessWidget {
  /// Функция обновления страницы
  final VoidCallback refresh;

  ///Конструктор
  const EmptyStateWidget({
    required this.refresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/error_state_placeholder.png',
          height: 255,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Сейчас здесь ничего нет',
          style: AppTextStyles().bold_16_21.copyWith(
                color: AppColors().primaryText,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: refresh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                TennisIcons.update,
                size: 16,
                color: AppColors().accentGreen,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Обновить данные',
                style: AppTextStyles().regular_14_19.copyWith(
                      color: AppColors().accentGreen,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
