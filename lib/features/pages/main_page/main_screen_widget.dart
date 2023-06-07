import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/coordinate.dart';
import 'package:soft_weather_tennis/features/pages/main_page/domain/navigation_bar_item.dart';
import 'package:soft_weather_tennis/features/pages/main_page/main_screen_wm.dart';
import 'package:soft_weather_tennis/features/pages/main_page/widgets/navigation_bar.dart'
    as nav;

/// Главная страница. Включает в себя нижний навигацонный бар.  Внутренние страницы.
class MainScreenWidget extends ElementaryWidget<IMainScreenWidgetModel> {
  final Map _bucketMap = <CoordinateBuilder, Widget>{};

  ///
  MainScreenWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultMainScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMainScreenWidgetModel wm) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: wm.scaffoldKey,
        drawerEnableOpenDragGesture: false,
        backgroundColor: AppColors().divider,
        body: StateNotifierBuilder(
          listenableState: wm.currentPage,
          builder: (context, builder) {
            if (!_bucketMap.containsKey(builder)) {
              final widget = (builder as CoordinateBuilder).call(context, null);
              _bucketMap[builder] = widget;
            }
            return IndexedStack(
              index: _bucketMap.keys.toList().indexOf(builder),
              children: _bucketMap.values.toList() as List<Widget>,
            );
          },
        ),
        bottomNavigationBar: MultiListenerRebuilder(
          listenableList: [
            wm.indexState,
            wm.isTrainerState,
            // TODO(daniil): add pages
          ],
          builder: (_) => nav.NavigationBar(
            selectedIndex: wm.indexState.value ?? 0,
            onTap: wm.onIndexChanged,
            selectedLabelStyle: AppTextStyles().light_12_16.copyWith(
                  color: AppColors().accentGreen,
                ),
            items: [
              const NavigationBarItem(
                icon: Icon(TennisIcons.ball),
                label: 'Игра', //wm.localization.bargaining,
              ),
              NavigationBarItem(
                icon: const Icon(TennisIcons.rating),
                label: 'Рейтинг', //wm.localization.schedule,
                isTrainer: wm.isTrainerState.value ?? true,
              ),
              // if (!(wm.isTrainerState.value ?? true))
              NavigationBarItem(
                icon: const Icon(TennisIcons.useful),
                label: 'Полезное', //wm.localization.schedule,
                isTrainer: wm.isTrainerState.value ?? true,
              ),
              const NavigationBarItem(
                icon: Icon(TennisIcons.best),
                label: 'Лучшие', //wm.localization.schedule,
              ),
              const NavigationBarItem(
                icon: Icon(TennisIcons.user),
                label: 'Профиль', //wm.localization.schedule,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
