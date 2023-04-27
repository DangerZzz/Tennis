import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_info.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/pages/useful_full_info_page/di/useful_scope.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/pages/useful_full_info_page/useful_full_info_page_model.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/pages/useful_full_info_page/useful_full_info_page_widget.dart';

///
abstract class IUsefulFullInfoPageWidgetModel extends IWidgetModel {
  ///
  ListenableState<EntityState<UsefulInfoData>> get usefulDataByIndex;

  ///
  double get width;

  ///
  double get height;

  ///
  void onBack();
}

///
UsefulFullInfoPageWidgetModel defaultUsefulFullInfoPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IUsefulFullInfoPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.usefulFullInfoPageModel;
  return UsefulFullInfoPageWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for UsefulFullInfoPageWidget
class UsefulFullInfoPageWidgetModel
    extends WidgetModel<UsefulFullInfoPageWidget, UsefulFullInfoPageModel>
    implements IUsefulFullInfoPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  @override
  ListenableState<EntityState<UsefulInfoData>> get usefulDataByIndex =>
      _usefulDataByIndex;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  double get height => MediaQuery.of(context).size.height;

  late EntityStateNotifier<UsefulInfoData> _usefulDataByIndex;

  /// Конструктор
  UsefulFullInfoPageWidgetModel(
    UsefulFullInfoPageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  @override
  void onBack() {
    coordinator.pop();
  }

  Future<void> _initLoad() async {
    _usefulDataByIndex = EntityStateNotifier<UsefulInfoData>();
    _usefulDataByIndex.loading();
    final index = ModalRoute.of(context)?.settings.arguments as int;
    final data = await model.usefulDataByIndex(index);
    _usefulDataByIndex.content(data);
  }
}
