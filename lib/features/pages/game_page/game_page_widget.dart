import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_wm.dart';

/// Main widget for GamePage module
class GamePageWidget extends ElementaryWidget<IGamePageWidgetModel> {
  ///
  const GamePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultGamePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGamePageWidgetModel wm) {
    return const Center(
      child: Text('Тут игра'),
    );
  }
}
