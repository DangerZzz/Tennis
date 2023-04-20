import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/di/settings_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class ISettingsPageWidgetModel extends IWidgetModel {
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
SettingsPageWidgetModel defaultSettingsPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<ISettingsPageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.settingsPageModel;
  return SettingsPageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for SettingsPageWidget
class SettingsPageWidgetModel
    extends WidgetModel<SettingsPageWidget, SettingsPageModel>
    implements ISettingsPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  ///Конструктор [SettingsPageWidgetModel]
  SettingsPageWidgetModel(
    SettingsPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);
}
