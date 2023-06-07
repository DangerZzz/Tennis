import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_player_info.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/di/pro_player_info_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_widget.dart';

///
abstract class IProPlayerInfoPageWidgetModel extends IWidgetModel {
  /// Все данные страницы
  ListenableState<EntityState<ProPlayerInfoData>> get proPlayerInfoData;

  ///
  double get width;

  ///
  double get height;

  /// Перход назад
  void back();

  /// Перход к игре
  void toGame();
}

///
ProPlayerInfoPageWidgetModel defaultProPlayerInfoPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IProPlayerInfoPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.proPlayerInfoPageModel;
  return ProPlayerInfoPageWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for ProPlayerInfoPageWidget
class ProPlayerInfoPageWidgetModel
    extends WidgetModel<ProPlayerInfoPageWidget, ProPlayerInfoPageModel>
    implements IProPlayerInfoPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  @override
  ListenableState<EntityState<ProPlayerInfoData>> get proPlayerInfoData =>
      _proPlayerInfoData;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  double get height => MediaQuery.of(context).size.height;

  late EntityStateNotifier<ProPlayerInfoData> _proPlayerInfoData;

  ///Конструктор
  ProPlayerInfoPageWidgetModel(
    ProPlayerInfoPageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _proPlayerInfoData = EntityStateNotifier<ProPlayerInfoData>();
    _proPlayerInfoData.loading();
    final data = await model.getProPlayerInfoData();
    _proPlayerInfoData.content(data);
  }

  @override
  Future<void> back() async {
    coordinator.pop();
  }

  @override
  Future<void> toGame() async {
    coordinator.navigate(
      context,
      AppCoordinate.newGamePage,
    );
  }
}
