import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/main_page/di/main_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/main_page/main_screen_model.dart';
import 'package:soft_weather_tennis/features/pages/main_page/main_screen_widget.dart';
import 'package:soft_weather_tennis/generated/l10n.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///страница-обертка
abstract class IMainScreenWidgetModel extends IWidgetModel {
  ///локализация
  AppLocalizations get localization;

  /// Координатор
  Coordinator get coordinator;

  /// ключ для скаффолда
  GlobalKey<ScaffoldState> get scaffoldKey;

  /// индекс табы
  StateNotifier<int> get indexState;

  /// Выбранная роль
  StateNotifier<bool> get isTrainerState;

  /// текущая страница
  StateNotifier<CoordinateBuilder> get currentPage;

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
  final userNotifier = appDependencies.userNotifier;
  final localDependencies = context.read<IMainPageScope>();
  final model = localDependencies.mainScreenModel;
  final localization = AppLocalizations.of(context);
  final coordinator = appDependencies.coordinator;
  return MainScreenWidgetModel(
    model,
    localization: localization,
    coordinator: coordinator,
    userNotifier: userNotifier,
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

  final UserNotifier _userNotifier;

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  @override
  StateNotifier<int> get indexState => _indexState;

  @override
  StateNotifier<bool> get isTrainerState => _isTrainerState;

  @override
  StateNotifier<CoordinateBuilder> get currentPage => _currentPage;

  late GlobalKey<ScaffoldState> _scaffoldKey;

  late StateNotifier<int> _indexState;

  late StateNotifier<bool> _isTrainerState;

  late StateNotifier<CoordinateBuilder> _currentPage;

  AppCoordinate? _appCoordinate;

  /// Конструктор WM
  MainScreenWidgetModel(
    MainScreenModel model, {
    required this.localization,
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  /// Инициализация изначального состояния страницы. Извлекает последнюю
  /// внутреннюю страницу из [coordinator]. Подписывается на изменения
  /// списка страниц
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _indexState = StateNotifier<int>()..accept(0);
    _isTrainerState = StateNotifier<bool>()..accept(_userNotifier.isTrainer);
    var name = AppCoordinate.gamePage.name;
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
    _userNotifier.addListener(userListener);
  }

  @override
  void dispose() {
    coordinator.removeListener(_coordinatorUpdate);
    _userNotifier.removeListener(userListener);
    super.dispose();
  }

  @override
  void onIndexChanged(int index) {
    switch (index) {
      case 0:
        _appCoordinate = AppCoordinate.gamePage;
        break;
      case 1:
        if (!(_isTrainerState.value ?? false)) {
          _appCoordinate = AppCoordinate.ratingPage;
        }
        break;
      case 2:
        if (!(_isTrainerState.value ?? false)) {
          _appCoordinate = AppCoordinate.usefulPage;
        }
        break;
      case 3:
        _appCoordinate = AppCoordinate.bestPage;
        break;
      case 4:
        _appCoordinate = AppCoordinate.profilePage;
        break;
      default:
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

  /// Обновляет состояние тренера
  void userListener() {
    _isTrainerState.accept(_userNotifier.isTrainer);
  }

  /// Функция отслеживания изменений в [coordinator]. Если последняя страница
  /// внутренняя, передает билдер этой страницы в виджет. Обновляет индекс
  /// для BottomBar
  void _coordinatorUpdate() {
    if (coordinator.pages.last.name!.endsWith('_inner')) {
      var name = AppCoordinate.gamePage.name;
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
    if (name == AppCoordinate.gamePage.name) {
      index = 0;
    } else if (name == AppCoordinate.ratingPage.name) {
      index = 1;
    } else if (name == AppCoordinate.usefulPage.name) {
      index = 2;
    } else if (name == AppCoordinate.bestPage.name) {
      index = 3;
    } else if (name == AppCoordinate.profilePage.name) {
      index = 4;
    }

    _indexState.accept(index);
  }
}
