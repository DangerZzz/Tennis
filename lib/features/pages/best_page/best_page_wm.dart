import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_model.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/best_page/di/best_page_scope.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IBestPageWidgetModel extends IWidgetModel {
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

  /// Конструктор
  BestPageWidgetModel(
    BestPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);
}
