import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/pages/game_connection_page.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/pages/game_progress_page.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/pages/hitch_page.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/pages/trainer_connection_page.dart';

/// Main widget for NewGamePage module
class NewGamePageWidget extends ElementaryWidget<INewGamePageWidgetModel> {
  ///
  const NewGamePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultNewGamePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(INewGamePageWidgetModel wm) {
    return EntityStateNotifierBuilder<int>(
      listenableEntityState: wm.index,
      builder: (_, index) => index == 0
          ? TrainerConnectionPage(wm: wm)
          : index == 1
              ? GameConnectionPage(wm: wm)
              : index == 2
                  ? GameProgressPage(wm: wm)
                  : HitchPage(wm: wm),
    );
  }
}
