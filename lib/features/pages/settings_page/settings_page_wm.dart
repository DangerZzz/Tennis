import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/components/snack_bar.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/di/settings_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/widgets/delete_dialog.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class ISettingsPageWidgetModel extends IWidgetModel {
  ///Данные пользователя
  UserInfo get userInfo;

  ///Данные пользователя
  UserNotifier get userNotifier;

  /// Кнопка "назад"
  void onBackToMain();

  /// Кнопка "сменить роль"
  void changeRole();

  /// Кнопка "выйти"
  void exit();

  /// Кнопка "удалить аккаунт"
  void deleteAccount();

  /// Кнопка "аватар профиля"
  void toAvatarPage();

  /// Кнопка "имя фамилия"
  void toEditName();

  /// Кнопка "характеристики"
  void toCharacteristicsPage();
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

  @override
  void changeRole() {
    coordinator.navigate(
      context,
      AppCoordinate.authScreen,
      arguments: 'rolePage',
    );
  }

  @override
  Future<void> exit() async {
    try {
      await model.exit();
      await _userNotifier.removeUser();
      //ignore:use_build_context_synchronously
      coordinator.replaceUntilRoot(
        context,
        AppCoordinate.authScreen,
      );
    } on FormatException catch (e) {
      //ignore:use_build_context_synchronously
      ShowSnackBar().showError(context);
    }
  }

  @override
  Future<void> deleteAccount() async {
    await showDialog<void>(
      builder: (context) {
        return const DeleteDialog();
      },
      context: context,
    );
  }

  @override
  Future<void> toAvatarPage() async {
    coordinator.navigate(
      context,
      AppCoordinate.avatarPage,
    );
  }

  @override
  Future<void> toEditName() async {
    coordinator.navigate(
      context,
      AppCoordinate.nameEditPage,
      arguments: _userInfo,
    );
  }

  @override
  Future<void> toCharacteristicsPage() async {
    coordinator.navigate(
      context,
      AppCoordinate.characteristicsPage,
    );
  }

  ///
  @override
  void onBackToMain() {
    coordinator.pop();
  }

  Future<void> _initLoad() async {}
}
