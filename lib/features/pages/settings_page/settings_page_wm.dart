import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/di/settings_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/domain/avatar_images.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/widgets/delete_dialog.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class ISettingsPageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  ///Данные пользователя
  UserInfo get userInfo;

  ///Данные пользователя
  UserNotifier get userNotifier;

  /// Контроллер текста
  TextEditingController get nameController;

  /// Контроллер текста
  TextEditingController get surnameController;

  /// Данные пользователя с бэка
  ListenableState<EntityState<CharactersInfo>> get charactersInfo;

  /// Данные пользователя с бэка
  ListenableState<EntityState<AvatarImages>> get avatarImagesData;

  /// Ширина страницы
  double get width;

  /// Кнопка "назад"
  void onBack();

  /// Кнопка "сменить роль"
  void changeRole();

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
    BuildContext context,) {
  final arguments = ModalRoute
      .of(context)
      ?.settings
      .arguments as UserInfo;
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
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  double get width =>
      MediaQuery
          .of(context)
          .size
          .width;

  @override
  UserNotifier get userNotifier => _userNotifier;

  @override
  UserInfo get userInfo => _userInfo;

  @override
  ListenableState<EntityState<int>> get index => _index;

  @override
  ListenableState<EntityState<CharactersInfo>> get charactersInfo =>
      _charactersInfo;

  @override
  ListenableState<EntityState<AvatarImages>> get avatarImagesData =>
      _avatarImagesData;

  @override
  TextEditingController get surnameController => _surnameController;

  @override
  TextEditingController get nameController => _nameController;

  late EntityStateNotifier<CharactersInfo> _charactersInfo;

  late EntityStateNotifier<AvatarImages> _avatarImagesData;

  late EntityStateNotifier<int> _index;

  ///Конструктор [SettingsPageWidgetModel]
  SettingsPageWidgetModel(SettingsPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
    required UserInfo userInfo,
  })
      : _userNotifier = userNotifier,
        _userInfo = userInfo,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  @override
  void onBack() {
    if (index.value?.data != 0) {
      _index.content(0);
    } else {
      onBackToMain();
    }
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
    // _avatarImagesData = EntityStateNotifier<AvatarImages>();
    // _avatarImagesData.loading();
    _index.content(1);
    final res = await model.getAvatarsData();
    _avatarImagesData.content(res);
  }

  @override
  Future<void> toEditName() async {
    _index.content(2);
    final res = await model.getAvatarsData();
    _avatarImagesData.content(res);
  }

  @override
  Future<void> toCharacteristicsPage() async {
    // _charactersInfo = EntityStateNotifier<CharactersInfo>();
    // _charactersInfo.loading();
    _index.content(3);
    final res = await model.getCharactersInfo();
    _charactersInfo.content(res);
  }

  ///
  void onBackToMain() {
    coordinator.pop();
  }

  Future<void> _initLoad() async {
    _avatarImagesData = EntityStateNotifier<AvatarImages>();
    _avatarImagesData.loading();
    _charactersInfo = EntityStateNotifier<CharactersInfo>();
    _charactersInfo.loading();
    _index = EntityStateNotifier<int>();

    _index.content(0);
  }
}
