import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/components/snack_bar.dart';
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

  /// Контроллер доступности кнопки "Далее" после ввода имени/фамилии
  ListenableState<EntityState<bool>> get nameButtonAvailability;

  /// Функция изменения доступности кнопки "далее" для имени-фамилии
  void nameEnterButtonAvailabilityFunction();

  /// Кнопка "назад"
  void onBack();

  /// Кнопка "изменить имя"
  void changeName();
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
  ListenableState<EntityState<bool>> get nameButtonAvailability =>
      _nameButtonAvailability;

  @override
  UserInfo get userInfo => _userInfo;

  @override
  TextEditingController get surnameController => _surnameController;

  @override
  TextEditingController get nameController => _nameController;

  late EntityStateNotifier<bool> _nameButtonAvailability;
  var _sendRequest = false;

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

  @override
  void nameEnterButtonAvailabilityFunction() {
    if (_nameController.text.length >= 2 &&
        _surnameController.text.length >= 2) {
      _nameButtonAvailability.content(true);
    } else {
      _nameButtonAvailability.content(false);
    }
  }

  ///
  @override
  Future<void> changeName() async {
    if (!_sendRequest) {
      _sendRequest = true;
      try {
        await model.changeName(
          name: _nameController.text,
          surname: _surnameController.text,
        );
        onBack();
      } on FormatException catch (e) {
        //ignore:use_build_context_synchronously
        ShowSnackBar().showError(context);
      }
      _sendRequest = false;
    }
  }

  ///
  @override
  void onBack() {
    coordinator.pop();
  }

  Future<void> _initLoad() async {
    _nameButtonAvailability = EntityStateNotifier<bool>();
    _nameButtonAvailability.content(false);
  }
}
