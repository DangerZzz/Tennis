import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/qr_reader_page.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/trainer_page_wm.dart';

/// Main widget for TrainerPage module
class TrainerPageWidget extends ElementaryWidget<ITrainerPageWidgetModel> {
  ///
  const TrainerPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultTrainerPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ITrainerPageWidgetModel wm) {
    return EntityStateNotifierBuilder<int>(
      listenableEntityState: wm.index,
      builder: (_, index) => index == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: wm.onQrTap,
                  child: Container(
                    width: 100,
                    height: 50,
                    color: AppColors().primaryText,
                  ),
                ),
                GestureDetector(
                  onTap: wm.toSettingsPage,
                  child: Container(
                    width: 100,
                    height: 50,
                    color: AppColors().gridRed,
                  ),
                ),
              ],
            )
          : QrReaderPage(wm: wm),
    );
  }
}
