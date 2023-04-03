import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/main_page/di/main_page_scope.dart';
import 'package:soft_weather_tennis/features/main_page/main_screen_model.dart';
import 'package:soft_weather_tennis/features/main_page/main_screen_widget.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/generated/l10n.dart';

///страница Ошибки связи
abstract class IMainScreenWidgetModel extends IWidgetModel {
  ///локализация
  AppLocalizations get localization;

  /// Координатор
  Coordinator get coordinator;

  /// ключ для скаффолда
  GlobalKey<ScaffoldState> get scaffoldKey;

  /// индекс табы
  StateNotifier<int> get indexState;

  // /// состояние авторизации
  // StateNotifier<bool> get authorizationState;

  /// текущая страница
  StateNotifier<CoordinateBuilder> get currentPage;

  // /// отображение бейджа у иконки
  // StateNotifier<bool> get cartBadgeState;

  /// колбэк для смены индекса
  void onIndexChanged(int index);

  /// колбэк на хардварную кнопку назад
  Future<bool> onWillPop();
}

/// фабрика для WM
MainScreenWidgetModel defaultMainScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final localDependencies = context.read<IMainPageScope>();
  final model = localDependencies.mainScreenModel;
  final localization = AppLocalizations.of(context);
  final coordinator = appDependencies.coordinator;
  return MainScreenWidgetModel(
    model,
    localization: localization,
    coordinator: coordinator,
  );
}

/// Виджет-модель для главного экрана. Подписывается на изменение списка
/// страниц в [coordinator]. Отслеживает состояние авторизации и наличие
/// изменений в корзине, заказах и заявках.
class MainScreenWidgetModel
    extends WidgetModel<MainScreenWidget, MainScreenModel>
    implements IMainScreenWidgetModel {
  @override
  final AppLocalizations localization;

  @override
  final Coordinator coordinator;

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  @override
  StateNotifier<int> get indexState => _indexState;

  // @override
  // StateNotifier<bool> get authorizationState => _authorizationState;

  // @override
  // StateNotifier<bool> get badgeState => _badgeState;

  @override
  StateNotifier<CoordinateBuilder> get currentPage => _currentPage;

  late GlobalKey<ScaffoldState> _scaffoldKey;

  late StateNotifier<int> _indexState;

  // late StateNotifier<bool> _authorizationState;

  late StateNotifier<bool> _badgeState;

  late StateNotifier<CoordinateBuilder> _currentPage;

  AppCoordinate? _appCoordinate;

  /// Конструктор WM
  MainScreenWidgetModel(
    MainScreenModel model, {
    required this.localization,
    required this.coordinator,
  }) : super(model);

  /// Инициализация изначального состояния страницы. Извлекает последнюю
  /// внутреннюю страницу из [coordinator]. Подписывается на изменения
  /// списка страниц
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _indexState = StateNotifier<int>()..accept(0);
    // _authorizationState = StateNotifier<bool>()..accept(_userNotifier.isLogin);
    // _badgeState = StateNotifier<bool>()..accept(false);
    var name = AppCoordinate.temp.name; // TODO(daniil): изменить
    if (coordinator.pages.any((element) => element.name!.endsWith('_inner'))) {
      name = (coordinator.pages
          .lastWhere((element) => element.name!.endsWith('_inner'))
          .name
          ?.replaceAll('_inner', ''))!;
    }

    final builderKey =
        appCoordinates.keys.firstWhere((element) => element.name == name);
    final builder = appCoordinates[builderKey];
    _currentPage = StateNotifier<CoordinateBuilder>()..accept(builder);
    _updateIndexByName(name);
    coordinator.addListener(_coordinatorUpdate);
    // _userNotifier.addListener(userListener);
  }

  @override
  void dispose() {
    coordinator.removeListener(_coordinatorUpdate);
    // _userNotifier.removeListener(userListener);
    super.dispose();
  }

  @override
  void onIndexChanged(int index) {
    final pageScope = context.read<IMainPageScope>();
    switch (index) {
      case 1:
        _appCoordinate = AppCoordinate.temp;
        // if (_appCoordinate == AppCoordinate.temp) {
        //   // ignore: avoid_dynamic_calls
        //   pageScope.scrollToTop?.call();
        // } else {
        //   _appCoordinate = AppCoordinate.temp;
        // }
        break;
      case 2:
        _appCoordinate = AppCoordinate.authScreen;
        // if (_authorizationState.value ?? false) {
        //   if (_appCoordinate == AppCoordinate.cartScreen) {
        //     // ignore: avoid_dynamic_calls
        //     pageScope.scrollToTopCart?.call();
        //   } else {
        //     _appCoordinate = AppCoordinate.cartScreen;
        //   }
        // } else {}
        break;
      case 3:
        // if (_authorizationState.value ?? false) {
        //   if (_appCoordinate == AppCoordinate.ordersScreen) {
        //     // ignore: avoid_dynamic_calls
        //     pageScope.scrollToTopOrders?.call();
        //   } else {
        //     _appCoordinate = AppCoordinate.ordersScreen;
        //   }
        // } else {}
        break;
      default:
      // if (_appCoordinate == AppCoordinate.catalogScreen) {
      //   // ignore: avoid_dynamic_calls
      //   pageScope.scrollToTopCatalog?.call();
      // } else {
      //   _appCoordinate = AppCoordinate.catalogScreen;
      // }
    }
    if (_appCoordinate != null) {
      coordinator.navigate(
        context,
        _appCoordinate!,
      );
    }
  }

  /// Обрабатывает системную кнопку назад.
  /// Если в навигаторе несколько внутренних страниц, убирает последнюю.
  /// Иначе передает событие дальше.
  @override
  Future<bool> onWillPop() async {
    if (coordinator.pages
            .where((page) => page.name?.endsWith('_inner') ?? false)
            .length >
        1) {
      coordinator.pop();
      return false;
    }
    return true;
  }

  // /// Обновляет состояние авторизации пользоваетля
  // @visibleForTesting
  // void userListener() {
  //   _authorizationState.accept(_userNotifier.isLogin);
  //   onIndexChanged(0);
  // }

  /// Функция отслеживания изменений в [coordinator]. Если последняя страница
  /// внутренняя, передает билдер этой страницы в виджет. Обновляет индекс
  /// для BottomBar
  void _coordinatorUpdate() {
    if (coordinator.pages.last.name!.endsWith('_inner')) {
      var name = AppCoordinate.temp.name; // TODO(daniil): исправить
      if (coordinator.pages.any(
        (element) => element.name!.endsWith('_inner'),
      )) {
        name = (coordinator.pages
            .lastWhere((element) => element.name!.endsWith('_inner'))
            .name
            ?.replaceAll('_inner', ''))!;
      }

      final builderKey =
          appCoordinates.keys.firstWhere((element) => element.name == name);
      final builder = appCoordinates[builderKey];
      _currentPage.accept(builder);
      _updateIndexByName(name);
    }
  }

  /// Обновляет выбранную вкладку в соответсвии с текущей внутренней страницей
  void _updateIndexByName(String name) {
    var index = 0;
    if (name == AppCoordinate.temp.name) {
      index = 0;
    } else if (name == AppCoordinate.authScreen.name) {
      index = 1;
      // TODO(daniil): add page name
    }
    // else if (name == AppCoordinate.cartScreen.name) {
    //   index = 2;
    //   // TODO(daniil): add page name
    // } else if (name == AppCoordinate.ordersScreen.name) {
    //   index = 3;
    // }

    _indexState.accept(index);
  }
}
