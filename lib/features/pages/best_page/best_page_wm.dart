import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_model.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/best_page/di/best_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IBestPageWidgetModel extends IWidgetModel {
  ///Данные страницы
  ListenableState<EntityState<BestDataList>> get bestDataList;

  ///
  double get width;

  /// Обновление страницы
  Future<void> onRefresh();

  // TODO(daniil): изменить после тестирования QA
  /// Обновление страницы
  Future<void> onRefreshToEmpty();
}

///
BestPageWidgetModel defaultBestPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IBestPageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.bestPageModel;
  return BestPageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for BestPageWidget
class BestPageWidgetModel extends WidgetModel<BestPageWidget, BestPageModel>
    implements IBestPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  ListenableState<EntityState<BestDataList>> get bestDataList => _bestDataList;

  late EntityStateNotifier<BestDataList> _bestDataList;

  /// Конструктор
  BestPageWidgetModel(
    BestPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _bestDataList = EntityStateNotifier<BestDataList>();

    // TODO(daniil): изменить после тестирования QA
    await _initLoadError();
    // await _initLoad();
  }

  @override
  Future<void> onRefresh() async {
    await _initLoad();
  }

  // TODO(daniil): изменить после тестирования QA
  @override
  Future<void> onRefreshToEmpty() async {
    await _initLoadEmpty();
  }

  // TODO(daniil): изменить после тестирования QA
  Future<void> _initLoadError() async {
    _bestDataList.loading();
    try {
      final data = await model.getBestListData();
      _bestDataList.error();
    } on FormatException catch (e) {
      _bestDataList.error(e);
    }
  }

  // TODO(daniil): изменить после тестирования QA
  Future<void> _initLoadEmpty() async {
    _bestDataList.loading();
    try {
      final data = await model.getBestListData();
      _bestDataList.content(BestDataList(bestData: []));
    } on FormatException catch (e) {
      _bestDataList.error(e);
    }
  }

  Future<void> _initLoad() async {
    _bestDataList.loading();
    try {
      final data = await model.getBestListData();
      _bestDataList.content(data);
    } on FormatException catch (e) {
      _bestDataList.error(e);
    }
  }
}
