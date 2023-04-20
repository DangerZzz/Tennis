import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/di/settings_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class ISettingsPageWidgetModel extends IWidgetModel {
  ///Данные пользователя
  UserInfo get userInfo;

  ///Данные пользователя
  UserNotifier get userNotifier;

  /// Данные пользователя с бэка
  ListenableState<EntityState<CharactersInfo>> get charactersInfo;
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
  final arguments = ModalRoute.of(context)?.settings.arguments as UserInfo;
  final scope = context.read<ISettingsPageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.settingsPageModel;
  return SettingsPageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
    userInfo: arguments,
  );
}

/// Default widget model for SettingsPageWidget
class SettingsPageWidgetModel
    extends WidgetModel<SettingsPageWidget, SettingsPageModel>
    implements ISettingsPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  final UserInfo _userInfo;

  @override
  UserNotifier get userNotifier => _userNotifier;

  @override
  UserInfo get userInfo => _userInfo;

  @override
  ListenableState<EntityState<CharactersInfo>> get charactersInfo =>
      _charactersInfo;

  late EntityStateNotifier<CharactersInfo> _charactersInfo;

  ///Конструктор [SettingsPageWidgetModel]
  SettingsPageWidgetModel(
    SettingsPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
    required UserInfo userInfo,
  })  : _userNotifier = userNotifier,
        _userInfo = userInfo,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  Future<void> _initLoad() async {
    _charactersInfo = EntityStateNotifier<CharactersInfo>();
    _charactersInfo.loading();
    final res = await model.getCharactersInfo();
    _charactersInfo.content(res);
  }
}
