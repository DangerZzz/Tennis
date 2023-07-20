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
  ListenableState<EntityState<List<BestData>>> get bestDataList;

  ///
  double get width;

  /// Обновление страницы
  Future<void> onRefresh();
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
  ListenableState<EntityState<List<BestData>>> get bestDataList =>
      _bestDataList;

  late EntityStateNotifier<List<BestData>> _bestDataList;

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
    await _initLoad();
  }

  @override
  Future<void> onRefresh() async {
    await _initLoad();
  }

  Future<void> _initLoad() async {
    _bestDataList = EntityStateNotifier<List<BestData>>();
    _bestDataList.loading();
    try {
      final data = await model.getBestListData();
      _bestDataList.content(data);
    } on FormatException catch (e) {
      _bestDataList.error(e);
    }
  }
}
