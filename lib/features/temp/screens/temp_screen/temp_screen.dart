import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/tennis_icons_icons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/temp/screens/temp_screen/temp_screen_widget_model.dart';
import 'package:soft_weather_tennis/generated/l10n.dart';

/// Initialization screens (this can be a HomeScreen or SplashScreen for example).
class TempScreen extends ElementaryWidget<TempScreenWidgetModel> {
  /// Create an instance [TempScreen].
  const TempScreen({
    Key? key,
    WidgetModelFactory wmFactory = initScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(TempScreenWidgetModel wm) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.current.textText * 2,
                      style: AppTextStyles()
                          .bold_12_14
                          .copyWith(color: AppColors().accentGreen),
                    ),
                    Text(
                      'test',
                      style: AppTextStyles()
                          .bold_14_19
                          .copyWith(color: AppColors().gradientEnd),
                    ),
                    Text(
                      'test',
                      style: AppTextStyles()
                          .bold_16_21
                          .copyWith(color: AppColors().gradientStart),
                    ),
                    Text(
                      'test',
                      style: AppTextStyles()
                          .bold_20_27
                          .copyWith(color: AppColors().gridRed),
                    ),
                    Text(
                      'test',
                      style: AppTextStyles()
                          .bold_24_32
                          .copyWith(color: AppColors().outYellow),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'test',
                      style: AppTextStyles()
                          .light_14_19
                          .copyWith(color: AppColors().primaryText),
                    ),
                    Text(
                      'test',
                      style: AppTextStyles().light_16_21.copyWith(
                            color: AppColors().secondaryText,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'test',
                      style: AppTextStyles().medium_14_19,
                    ),
                    Text(
                      'test',
                      style: AppTextStyles().medium_16_21,
                    ),
                    Text(
                      'test',
                      style: AppTextStyles().medium_18_24,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'test',
                      style: AppTextStyles().regular_12_14,
                    ),
                    Text(
                      'test',
                      style: AppTextStyles().regular_12_16,
                    ),
                    Text(
                      'test',
                      style: AppTextStyles().regular_14_19,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'test',
                      style: AppTextStyles().semibold_16_21,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Icon(Tennis_icons.rating1),
                    Icon(Tennis_icons.profile),
                    Icon(Tennis_icons.back1),
                    Icon(Tennis_icons.best1),
                    Icon(Tennis_icons.calendar1),
                    Icon(Tennis_icons.check),
                    Icon(Tennis_icons.user1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Icon(Tennis_icons.close1),
                    Icon(Tennis_icons.cup1),
                    Icon(Tennis_icons.edit1),
                    Icon(Tennis_icons.face_id1),
                    Icon(Tennis_icons.game1),
                    Icon(Tennis_icons.grid),
                    Icon(Tennis_icons.star_filled1),
                    Icon(Tennis_icons.useful1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Icon(Tennis_icons.name1),
                    Icon(Tennis_icons.out1),
                    Icon(Tennis_icons.refresh1),
                    Icon(Tennis_icons.role1),
                    Icon(Tennis_icons.search1),
                    Icon(Tennis_icons.setting),
                    Icon(Tennis_icons.star_empty),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: wm.toMain,
              child: Container(
                height: 100,
                width: 200,
                color: AppColors().outYellow,
                child: Text('press me'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
