import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/temp/di/temp_scope.dart';
import 'package:soft_weather_tennis/features/temp/screens/temp_screen/temp_screen.dart';
import 'package:soft_weather_tennis/features/temp/screens/temp_screen/temp_screen_model.dart';

/// Factory for [TempScreenWidgetModel].
TempScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final scope = context.read<ITempScreenScope>();
  final model = scope.tempScreenModel;
  return TempScreenWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Widget model for [TempScreen].
class TempScreenWidgetModel extends WidgetModel<TempScreen, TempScreenModel>
    implements IDebugWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  ///
  TempScreenWidgetModel(
    TempScreenModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  void toMain() {
    coordinator.navigate(
      context,
      AppCoordinate.mainScreen,
    );
  }
}

/// Interface of [TempScreenWidgetModel].
abstract class IDebugWidgetModel extends IWidgetModel {
  void toMain();
}
