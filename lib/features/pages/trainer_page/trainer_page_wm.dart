import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/components/snack_bar.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/di/trainer_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/trainer_page_model.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/trainer_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class ITrainerPageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Данные пользователя
  ListenableState<EntityState<UserInfo>> get userInfo;

  /// Открытие экрана сканирования QR
  Future<void> onQrTap();

  /// Открытие экрана сканирования QR
  Future<void> sendCode(String code);

  /// Переход в настройки
  Future<void> toSettingsPage();
}

///
TrainerPageWidgetModel defaultTrainerPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<ITrainerPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.trainerPageModel;
  final userNotifier = appDependencies.userNotifier;
  return TrainerPageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for TrainerPageWidget
class TrainerPageWidgetModel
    extends WidgetModel<TrainerPageWidget, TrainerPageModel>
    implements ITrainerPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  @override
  ListenableState<EntityState<UserInfo>> get userInfo => _userInfo;

  @override
  ListenableState<EntityState<int>> get index => _index;

  late EntityStateNotifier<int> _index;
  late EntityStateNotifier<UserInfo> _userInfo;

  ///
  final UserNotifier _userNotifier;

  ///конструктор
  TrainerPageWidgetModel(
    TrainerPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  @override
  Future<void> toSettingsPage() async {
    coordinator.navigate(
      context,
      AppCoordinate.settingsPage,
      arguments: _userInfo.value?.data,
    );
  }

  @override
  Future<void> onQrTap() async {
    const options = ScanOptions(
      strings: {
        'cancel': 'Отмена',
        'flash_on': 'Включить фонарь',
        'flash_off': 'Выключить фонарь',
      },
    );
    final cameraScanResult = await BarcodeScanner.scan(options: options);

    if (cameraScanResult.rawContent.isNotEmpty) {
      //ignore: use_build_context_synchronously
      coordinator.navigate(
        context,
        AppCoordinate.trainerGamePage,
        arguments: cameraScanResult.rawContent,
      );
    }
    // _index.content(1);
    // if (result != null) {

    // }
  }

  @override
  Future<void> sendCode(String code) async {
    // if (result != null) {
    //   //ignore: use_build_context_synchronously
    coordinator.navigate(
      context,
      AppCoordinate.trainerGamePage,
      arguments: code,
    );
    // }
  }

  Future<void> _initLoad() async {
    _index = EntityStateNotifier<int>();
    _index.content(0);
    _userInfo = EntityStateNotifier<UserInfo>();

    _userInfo.loading();
    try {
      _userInfo.loading();
      final data = await model.getUserInfo();
      _userInfo.content(data);
    } on FormatException catch (e) {
      _userInfo.error(e);
      //ignore:use_build_context_synchronously
      ShowSnackBar().showError(context);
    }
    // try {
    //   final data = await model.getUsefulData(
    //     limit: _limit,
    //     page: _page,
    //   );
    //   _usefulData.content(data);
    // } on FormatException catch (e) {
    //   _usefulData.error(e);
    // }
  }
}
