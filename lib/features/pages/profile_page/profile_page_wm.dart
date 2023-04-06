import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/di/profile_scope.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_model.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IProfilePageWidgetModel extends IWidgetModel {
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
ProfilePageWidgetModel defaultProfilePageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IProfilePageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.profilePageModel;
  return ProfilePageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for ProfilePageWidget
class ProfilePageWidgetModel
    extends WidgetModel<ProfilePageWidget, ProfilePageModel>
    implements IProfilePageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  /// Конструктор
  ProfilePageWidgetModel(
    ProfilePageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);
}
