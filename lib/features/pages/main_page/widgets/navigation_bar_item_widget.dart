import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/main_page/domain/navigation_bar_item.dart';

/// Виджет элемента [BottomNavigationBar]
class NavigationBarItemWidget extends StatelessWidget {
  /// Данные для виджета
  final NavigationBarItem item;

  /// Цвет иконки и текста. Применяется к тексту при отсутсвии [labelStyle]
  final Color? color;

  /// Размер иконки
  final double iconSize;

  /// Стильт текста
  final TextStyle? labelStyle;

  ///
  const NavigationBarItemWidget({
    required this.item,
    required this.iconSize,
    Key? key,
    this.color,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconTheme(
                data: IconThemeData(
                  color: (item.isTrainer ?? false)
                      ? AppColors().notAvailable
                      : color,
                  size: iconSize,
                ),
                child: item.icon,
              ),
              Text(
                item.label,
                style: (item.isTrainer ?? false)
                    ? AppTextStyles()
                        .light_12_16
                        .copyWith(color: AppColors().notAvailable)
                    : labelStyle ?? AppTextStyles().light_12_16,
              ),
            ],
          ),
        ),
        // if (item.badge != null)
        //   Align(
        //     alignment: Alignment.topCenter,
        //     // right: 0,
        //     // top: 5,
        //     child: Padding(
        //       padding: EdgeInsets.only(left: iconSize + 10, top: 5),
        //       child: item.badge,
        //     ),
        //   ),
      ],
    );
  }
}
