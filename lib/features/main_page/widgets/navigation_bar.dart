import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/main_page/domain/navigation_bar_item.dart';
import 'package:soft_weather_tennis/features/main_page/widgets/navigation_bar_item_widget.dart';

/// Навигационний бар
class NavigationBar extends StatelessWidget {
  /// Элементы, распологаются в [Row] с [MainAxisAlignment.spaceBetween]
  final List<NavigationBarItem> items;

  /// Текущий индекс из [items]
  final int selectedIndex;

  /// Цвет выбранного элемента. Применяется к иконе и к тексту при условии
  ///```dart
  /// selectedLabelStyle == null
  ///```
  final Color selectedColor;

  /// Цвет элементов кроме выбранного. Применяется к иконе и к тексту при условии
  ///```dart
  /// selectedLabelStyle == null
  ///```
  final Color unselectedColor;

  /// Стиль выбранного текста
  final TextStyle? selectedLabelStyle;

  /// Стиль невыбранного текста
  final TextStyle? unselectedLabelStyle;

  /// Размер иконки
  final double iconSize;

  /// Коллбэк нажатия. Передает выбранный индекс
  final Function(int index)? onTap;

  ///
  const NavigationBar({
    Key? key,
    this.items = const [],
    this.selectedIndex = 0,
    this.iconSize = 24.0,
    this.selectedColor = const Color(0xffA8DB19),
    this.unselectedColor = const Color(0xff313131),
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.onTap,
  })  : assert(selectedIndex < items.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 3,
      child: SizedBox(
        height: 54,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: InkResponse(
                    enableFeedback: false,
                    onTap: () => onTap?.call(i),
                    child: NavigationBarItemWidget(
                      item: items[i],
                      color:
                          i == selectedIndex ? selectedColor : unselectedColor,
                      iconSize: iconSize,
                      labelStyle: i == selectedIndex
                          ? selectedLabelStyle
                          : unselectedLabelStyle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
