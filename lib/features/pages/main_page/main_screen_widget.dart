import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/tennis_icons_icons.dart';
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
      onWillPop: wm.onWillPop,
      child: Scaffold(
        key: wm.scaffoldKey,
        drawerEnableOpenDragGesture: false,
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
            // TODO(daniil): add pages
          ],
          builder: (_) => nav.NavigationBar(
            selectedIndex: wm.indexState.value ?? 0,
            onTap: wm.onIndexChanged,
            items: [
              const NavigationBarItem(
                icon: Icon(Tennis_icons.game1),
                label: 'Игра', //wm.localization.bargaining,
              ),
              NavigationBarItem(
                icon: const Icon(Tennis_icons.rating1),
                label: 'Рейтинг', //wm.localization.schedule,
                isTrainer: wm.isTrainerState.value ?? true,
              ),
              // if (!(wm.isTrainerState.value ?? true))
              NavigationBarItem(
                icon: const Icon(Tennis_icons.useful1),
                label: 'Полезное', //wm.localization.schedule,
                isTrainer: wm.isTrainerState.value ?? true,
              ),
              const NavigationBarItem(
                icon: Icon(Tennis_icons.best1),
                label: 'Лучшие', //wm.localization.schedule,
              ),
              const NavigationBarItem(
                icon: Icon(Tennis_icons.profile),
                label: 'Профиль', //wm.localization.schedule,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
