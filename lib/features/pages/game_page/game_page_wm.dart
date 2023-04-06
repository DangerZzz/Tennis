import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/di/game_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IGamePageWidgetModel extends IWidgetModel {
  // ///
  // ListenableState<EntityState<bool>> get a;
  //
  // ///
  // String get b;
  //
  // ///
  // void c(String p);
}

///
GamePageWidgetModel defaultGamePageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IGamePageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.gamePageModel;
  return GamePageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for GamePageWidget
class GamePageWidgetModel extends WidgetModel<GamePageWidget, GamePageModel>
    implements IGamePageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  /// Конструктор
  GamePageWidgetModel(
    GamePageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);
}
