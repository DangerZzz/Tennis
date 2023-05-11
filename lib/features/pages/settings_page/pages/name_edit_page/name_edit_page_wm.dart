import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page/di/name_edit_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page/name_edit_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page/name_edit_page_widget.dart';

///
abstract class INameEditPageWidgetModel extends IWidgetModel {
  ///Данные пользователя
  UserInfo get userInfo;

  /// Контроллер текста
  TextEditingController get nameController;

  /// Контроллер текста
  TextEditingController get surnameController;

  /// Кнопка "назад"
  void onBack();
}

///
NameEditPageWidgetModel defaultNameEditPageWidgetModelFactory(
  BuildContext context,
) {
  final arguments = ModalRoute.of(context)?.settings.arguments as UserInfo;
  final scope = context.read<INameEditPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.nameEditPageModel;

  return NameEditPageWidgetModel(
    model,
    coordinator: coordinator,
    userInfo: arguments,
  );
}

/// Default widget model for NameEditPageWidget
class NameEditPageWidgetModel
    extends WidgetModel<NameEditPageWidget, NameEditPageModel>
    implements INameEditPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserInfo _userInfo;
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  UserInfo get userInfo => _userInfo;

  @override
  TextEditingController get surnameController => _surnameController;

  @override
  TextEditingController get nameController => _nameController;

  ///
  NameEditPageWidgetModel(
    NameEditPageModel model, {
    required this.coordinator,
    required UserInfo userInfo,
  })  : _userInfo = userInfo,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  ///
  @override
  void onBack() {
    coordinator.pop();
  }

  Future<void> _initLoad() async {}
}
