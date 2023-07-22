import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/pages/edit_image_page.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/pages/main_avatar_page.dart';

/// Main widget for AvatarPage module
class AvatarPageWidget extends ElementaryWidget<IAvatarPageWidgetModel> {
  ///
  const AvatarPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultAvatarPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAvatarPageWidgetModel wm) {
    return EntityStateNotifierBuilder<int>(
      listenableEntityState: wm.index,
      builder: (_, index) => Scaffold(
        backgroundColor: AppColors().white,
        appBar: index != 1
            ? AppBar(
                centerTitle: false,
                backgroundColor: AppColors().white,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                shadowColor: Colors.transparent,
                leading: InkWell(
                  onTap: index != 0 ? wm.onBackWithIndex : wm.onBack,
                  child: Icon(
                    TennisIcons.back,
                    color: AppColors().primaryText,
                    size: 12,
                  ),
                ),
                title: Text(
                  'Настройки',
                  style: AppTextStyles().bold_24_32.copyWith(
                        color: AppColors().primaryText,
                      ),
                ),
              )
            : null,
        body: index!.toInt() == 0
            ?

            ///Главная страница
            MainAvatarPage(widgetModel: wm)
            : index.toInt() == 1
                ?

                ///Страница редактирования изображения
                EditImagePage(widgetModel: wm)
                : Container(),
      ),
    );
  }
}
