import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/pages/hitch_page.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/pages/waiting_game_page.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/trainer_game_page_wm.dart';

/// Main widget for TrainerGamePage module
class TrainerGamePageWidget
    extends ElementaryWidget<ITrainerGamePageWidgetModel> {
  ///
  const TrainerGamePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultTrainerGamePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ITrainerGamePageWidgetModel wm) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: EntityStateNotifierBuilder<int>(
        listenableEntityState: wm.index,
        builder: (_, index) =>
            index == 0 ? WaitingGamePage(wm: wm) : HitchTrainerPage(wm: wm),
        // index == 1
        //         ? TrainerConnectionPage(wm: wm)
        //         : index == 2
        //             ? GameConnectionPage(wm: wm)
        //             : index == 3
        //                 ? HitchPage(wm: wm)
        //                 : GameProgressPage(wm: wm),
      ),
    );
  }
}
