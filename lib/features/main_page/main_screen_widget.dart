import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/tennis_icons_icons.dart';
import 'package:soft_weather_tennis/features/main_page/domain/navigation_bar_item.dart';
import 'package:soft_weather_tennis/features/main_page/main_screen_wm.dart';
import 'package:soft_weather_tennis/features/main_page/widgets/navigation_bar.dart'
    as nav;
import 'package:soft_weather_tennis/features/navigation/domain/entity/coordinate.dart';

/// Главная страница. Включает в себя нижний навигацонный бар. Drawer
/// с личным кабинетом. Внутренние страницы.
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
            items: const [
              NavigationBarItem(
                icon: Icon(Tennis_icons.game1),
                label: 'Игра', //wm.localization.bargaining,
              ),
              NavigationBarItem(
                icon: Icon(Tennis_icons.rating1),
                label: 'Рейтинг', //wm.localization.schedule,
              ),
              NavigationBarItem(
                icon: Icon(Tennis_icons.useful1),
                label: 'Полезное', //wm.localization.schedule,
              ),
              NavigationBarItem(
                icon: Icon(Tennis_icons.best1),
                label: 'Лучшие', //wm.localization.schedule,
              ),
              NavigationBarItem(
                icon: Icon(Tennis_icons.profile),
                label: 'Профиль', //wm.localization.schedule,
              ),

              // if (wm.authorizationState.value ?? false) ...[
              //   NavigationBarItem(
              //     icon: const Icon(SeverstalIcons.shopping_cart),
              //     label: wm.localization.cart,
              //     badge:
              //         wm.cartBadgeState.value ?? false ? const Badge() : null,
              //   ),
              //   NavigationBarItem(
              //     icon: const Icon(SeverstalIcons.package),
              //     label: wm.localization.orders,
              //     badge:
              //         wm.ordersBadgeState.value ?? false ? const Badge() : null,
              //   ),
              // ] else ...[
              //   NavigationBarItem(
              //     icon: const Icon(SeverstalIcons.book_open),
              //     label: wm.localization.rules,
              //   ),
              //   NavigationBarItem(
              //     icon: const Icon(SeverstalIcons.file_text),
              //     label: wm.localization.policy,
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
