import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/di/useful_scope.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_info.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_model.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IUsefulPageWidgetModel extends IWidgetModel {
  ///
  ListenableState<EntityState<UsefulData>> get usefulData;

  ///
  double get width;

  /// Обновление страницы
  Future<void> onRefresh();

  /// Страница конкретного совета
  void toInfoPage(int index);
}

///
UsefulPageWidgetModel defaultUsefulPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IUsefulPageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.usefulPageModel;
  return UsefulPageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for UsefulPageWidget
class UsefulPageWidgetModel
    extends WidgetModel<UsefulPageWidget, UsefulPageModel>
    implements IUsefulPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  ListenableState<EntityState<UsefulData>> get usefulData => _usefulData;

  @override
  ListenableState<EntityState<UsefulInfoData>> get usefulDataByIndex =>
      _usefulDataByIndex;

  late EntityStateNotifier<UsefulData> _usefulData;

  late EntityStateNotifier<UsefulInfoData> _usefulDataByIndex;

  /// Конструктор
  UsefulPageWidgetModel(
    UsefulPageModel model, {
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
  Future<void> onRefresh() async {
    await _initLoad();
  }

  @override
  Future<void> toInfoPage(int index) async {
    coordinator.navigate(
      context,
      AppCoordinate.usefulFullInfoPage,
      arguments: index,
    );
  }

  Future<void> _initLoad() async {
    _usefulData = EntityStateNotifier<UsefulData>();
    _usefulData.loading();

    try {
      final data = await model.getUsefulData();
      _usefulData.content(data);
    } on FormatException catch (e) {
      _usefulData.error(e);
    }
  }
}
