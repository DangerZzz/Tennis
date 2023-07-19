import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/snack_bar.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_model.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/di/authorizarion_scope.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/tools/code_text_field_tool.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IAuthorizationPageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Контроллер текста номера телефона
  TextEditingController get phoneController;

  /// Контроллер текста pin-кода
  TextEditingController get pinController;

  /// Контроллер текста фамилии
  TextEditingController get surnameController;

  /// Контроллер текста имени
  TextEditingController get nameController;

  /// Контроллер доступности кнопки "получить код"
  ListenableState<EntityState<bool>> get phoneButtonAvailability;

  /// Контроллер доступности кнопки "Далее" после ввода кода из смс
  ListenableState<EntityState<bool>> get codeButtonAvailability;

  /// Контроллер доступности кнопки "Далее" после ввода пин-кода
  ListenableState<EntityState<bool>> get pinButtonAvailability;

  /// Контроллер доступности кнопки "Далее" после ввода имени/фамилии
  ListenableState<EntityState<bool>> get nameButtonAvailability;

  ///контроллер принятия биометрии
  ListenableState<EntityState<bool>> get acceptBiometrics;

  /// Флаг отправки кода
  ListenableState<EntityState<bool>> get codeIsSend;

  /// Флаг равенства пин-кодов
  ListenableState<EntityState<bool>> get equalsPin;

  /// Флаг первого запуска приложения
  ListenableState<EntityState<bool>> get firstEnter;

  /// Флаг доступности входа по биометрии
  ListenableState<EntityState<bool>> get biometricEnterFlag;

  /// Флаг доступности входа по биометрии
  bool get sendAnyRequest;

  /// контроллер и маска для textField
  CodeTextFieldTool get codeTextFieldTool;

  /// Маска для номера телефона
  MaskTextInputFormatter get phoneMaskFormatter;

  /// Маска для pin-кода
  MaskTextInputFormatter get pinMaskFormatter;

  /// Обработчик TextField-ов - переключение между ними,
  /// отправка запроса при заполнении всех запросов
  void handlerField(String p);

  /// Функция изменения доступности кнопки "получить код"
  void phoneButtonAvailabilityFunction();

  /// Функция изменения доступности кнопки "далее" для пин-кода
  void pinButtonAvailabilityFunction();

  /// Функция изменения доступности кнопки "далее" для имени-фамилии
  void nameEnterButtonAvailabilityFunction();

  /// Функция запроса кода
  void getCode(String code);

  /// Функция отправки кода
  void sendCode(String code);

  /// Функция установки/ввода пин-кода
  void setPin(String code);

  /// Функция входа по биометрии
  void biometricEnter();

  /// Функция установки фамилии/имени
  void setName(String name, String surname);

  /// Функция перехода на главную
  void toMain();

  /// Функция сохранения всех данных
  void completeRegistration(bool isTrainer);

  /// Функция перехода на восстановление пароля
  void toRestorePass();
}

///
AuthorizationPageWidgetModel defaultAuthorizationPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IAuthorizationPageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.authorizationPageModel;
  return AuthorizationPageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for AuthorizationPageWidget
class AuthorizationPageWidgetModel
    extends WidgetModel<AuthorizationPageWidget, AuthorizationPageModel>
    implements IAuthorizationPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final CodeTextFieldTool _codeTextFieldTool = CodeTextFieldTool();

  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {'#': RegExp('[0-9]')},
  );
  final _pinMaskFormatter = MaskTextInputFormatter(
    mask: '######',
    filter: {'#': RegExp('[0-9]')},
  );

  @override
  ListenableState<EntityState<int>> get index => _index;

  @override
  TextEditingController get phoneController => _phoneController;

  @override
  TextEditingController get pinController => _pinController;

  @override
  TextEditingController get surnameController => _surnameController;

  @override
  TextEditingController get nameController => _nameController;

  @override
  ListenableState<EntityState<bool>> get acceptBiometrics => _acceptBiometrics;

  @override
  ListenableState<EntityState<bool>> get phoneButtonAvailability =>
      _phoneButtonAvailability;

  @override
  ListenableState<EntityState<bool>> get codeButtonAvailability =>
      _codeButtonAvailability;

  @override
  bool get sendAnyRequest => _sendAnyRequest;

  @override
  ListenableState<EntityState<bool>> get pinButtonAvailability =>
      _pinButtonAvailability;

  @override
  ListenableState<EntityState<bool>> get biometricEnterFlag =>
      _biometricEnterFlag;

  @override
  ListenableState<EntityState<bool>> get firstEnter => _firstEnter;

  @override
  ListenableState<EntityState<bool>> get nameButtonAvailability =>
      _nameButtonAvailability;

  @override
  ListenableState<EntityState<bool>> get codeIsSend => _codeIsSend;

  @override
  ListenableState<EntityState<bool>> get equalsPin => _equalsPin;

  @override
  CodeTextFieldTool get codeTextFieldTool => _codeTextFieldTool;

  @override
  MaskTextInputFormatter get phoneMaskFormatter => _phoneMaskFormatter;

  @override
  MaskTextInputFormatter get pinMaskFormatter => _pinMaskFormatter;

  late EntityStateNotifier<int> _index;

  late EntityStateNotifier<bool> _phoneButtonAvailability;
  late EntityStateNotifier<bool> _codeButtonAvailability;
  late EntityStateNotifier<bool> _pinButtonAvailability;
  late EntityStateNotifier<bool> _nameButtonAvailability;
  late EntityStateNotifier<bool> _codeIsSend;
  late EntityStateNotifier<bool> _biometricEnterFlag;
  late EntityStateNotifier<bool> _firstEnter;
  late EntityStateNotifier<bool> _equalsPin;
  late EntityStateNotifier<bool> _acceptBiometrics;
  late bool _sendAnyRequest;

  bool _isRestorePass = false;

  /// Конструктор
  AuthorizationPageWidgetModel(
    AuthorizationPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _index = EntityStateNotifier<int>();
    _index.loading();
    _phoneButtonAvailability = EntityStateNotifier<bool>();
    _phoneButtonAvailability.content(false);
    _codeButtonAvailability = EntityStateNotifier<bool>();
    _codeButtonAvailability.content(false);
    _pinButtonAvailability = EntityStateNotifier<bool>();
    _pinButtonAvailability.content(false);
    _nameButtonAvailability = EntityStateNotifier<bool>();
    _nameButtonAvailability.content(false);
    _codeIsSend = EntityStateNotifier<bool>();
    _codeIsSend.content(false);
    _equalsPin = EntityStateNotifier<bool>();
    _equalsPin.content(false);
    _acceptBiometrics = EntityStateNotifier<bool>();
    _acceptBiometrics.content(false);
    _sendAnyRequest = false;
    _biometricEnterFlag = EntityStateNotifier<bool>();
    _firstEnter = EntityStateNotifier<bool>();
    await _userNotifier.loginCode.loadCode();
    await _userNotifier.loadLoginSettings();
    _biometricEnterFlag.content(_userNotifier.loginCode.codeHash != null &&
        _userNotifier.canUseBiometric &&
        _userNotifier.biometricLogin);
    _firstEnter.content(_userNotifier.loginCode.codeHash == null);
    await _initIndex();
  }

  @override
  Future<void> getCode(String code) async {
    _codeIsSend.loading();
    // await _userNotifier.loginCode.loadPhone();
    // final isNewPhone = _userNotifier.loginCode.phone ?? '';
    // if (isNewPhone.replaceAll(' ', '') ==
    //     _phoneController.text.replaceAll(' ', '') &&
    //     (_userNotifier.loginCode.code?.isNotEmpty ?? false)) {
    //   _isRestorePass = true;
    // } else {
    //   _isRestorePass = false;
    // }
    try {
      final isRegistered = await model.getCode(
        phone: _phoneController.text.replaceAll(' ', ''),
        //type: 'SIGNUP', //_isRestorePass ? 'RECOVERY' : 'SIGNUP',
      );
      _isRestorePass = isRegistered ?? false;
      //ignore:use_build_context_synchronously
      // ShowSnackBar().showSuccess(context, code ?? '');
      _codeIsSend.content(true);
    } on FormatException catch (e) {
      debugPrint('$e');
      //ignore:use_build_context_synchronously
      ShowSnackBar().showError(context);
      _codeIsSend.content(false);
    }
  }

  @override
  void phoneButtonAvailabilityFunction() {
    if (_phoneButtonAvailability.value?.data == false &&
        _phoneController.text.length >= 18) {
      _phoneButtonAvailability.content(true);
    } else {
      _phoneButtonAvailability.content(false);
      _codeIsSend.content(false);
    }
  }

  @override
  Future<void> handlerField(String p) async {
    if (p.length == 4) {
      _codeButtonAvailability.content(true);
    } else {
      _codeButtonAvailability.content(false);
    }
  }

  @override
  void pinButtonAvailabilityFunction() {
    if (_pinButtonAvailability.value?.data == false &&
        _pinController.text.length >= 6) {
      _pinButtonAvailability.content(true);
    } else {
      _equalsPin.content(false);
      _pinButtonAvailability.content(false);
    }
  }

  @override
  Future<void> sendCode(String code) async {
    FocusScope.of(context).unfocus();
    _codeButtonAvailability.loading();
    try {
      await model.sendCode(
        code: _codeTextFieldTool.textEditingController.text,
      );
      _codeButtonAvailability.content(true);
      _index.content(1);
    } on FormatException catch (e) {
      debugPrint('$e');
      ShowSnackBar().showError(context);
      _codeButtonAvailability.content(false);
    }
  }

  @override
  Future<void> setPin(String code) async {
    FocusScope.of(context).unfocus();
    await _userNotifier.loginCode.loadCode();

    if (_isRestorePass) {
      await _userNotifier.loginCode.clear();
    }

    /// Записать код
    if (_userNotifier.loginCode.codeHash == null) {
      //ignore: use_build_context_synchronously
      await showDialog<void>(
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Использовать данные биометрии для входа?',
              style: AppTextStyles()
                  .medium_16_21
                  .copyWith(color: AppColors().primaryText),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  _acceptBiometrics.content(false);
                  Navigator.pop(context); // TODO(daniil): coordinator.pop();
                },
                child: Text(
                  'Нет',
                  style: AppTextStyles().medium_16_21.copyWith(
                        color: AppColors().primaryText,
                      ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  onBiometrics();
                  Navigator.pop(context); // TODO(daniil): coordinator.pop();
                },
                child: Text(
                  'Да',
                  style: AppTextStyles().medium_16_21.copyWith(
                        color: AppColors().primaryText,
                      ),
                ),
              ),
            ],
          );
        },
        context: context,
      );

      if (_isRestorePass) {
        try {
          await model.recovery(
            password: _pinController.text,
          );

          await _userNotifier.loginCode.updateCode(_pinController.text);
          if (_userNotifier.canUseBiometric) {
            if (_acceptBiometrics.value?.data ?? false) {
              await _userNotifier
                  .updateBiometricStorage(_firstEnter.value?.data ?? true);
              debugPrint('Биометрия сохранена');
            }
          }
          await _userNotifier.loginCode.updatePhone(_phoneController.text);
          await _userNotifier.saveTokens(_pinController.text);
          await _userNotifier.loginCode
              .updatePhone(_phoneController.text.replaceAll(' ', ''));
          await _userNotifier.loginCode.loadPhone();
          await model.signIn(
            phone: '${_userNotifier.loginCode.phone}'.replaceAll(' ', ''),
            password: _pinController.text,
          );
          toMain();
        } on FormatException catch (e) {
          debugPrint('$e');
          //ignore:use_build_context_synchronously
          ShowSnackBar().showError(context);
        }
      } else {
        _index.content(2);
      }
      return;
    }

    ///сравнение кодов
    if (_userNotifier.loginCode.compare(code)) {
      try {
        await _userNotifier.loadTokens(code);
        await _userNotifier.loginCode.loadPhone();
        debugPrint(
          'Телефон ${_userNotifier.loginCode.phone}'.replaceAll(' ', ''),
        );
        await model.signIn(
          phone: '${_userNotifier.loginCode.phone}'.replaceAll(' ', ''),
          password: code,
        );
        toMain();
      } on FormatException catch (e) {
        debugPrint('$e');
        //ignore:use_build_context_synchronously
        ShowSnackBar().showError(context);
      }
    } else {
      debugPrint('Код неверный');
      _equalsPin.content(true);
    }
  }

  @override
  Future<void> biometricEnter() async {
    final code = await _userNotifier.authorizeBiometrics();
    if (!_sendAnyRequest) {
      _sendAnyRequest = true;

      ///сравнение кодов
      if (_userNotifier.loginCode.compare(code!)) {
        try {
          await _userNotifier.loadTokens(code);
          await _userNotifier.loginCode.loadPhone();
          debugPrint(
            'Телефон ${_userNotifier.loginCode.phone}'.replaceAll(' ', ''),
          );
          await model.signIn(
            phone: '${_userNotifier.loginCode.phone}'.replaceAll(' ', ''),
            password: code,
          );
          toMain();
        } on FormatException catch (e) {
          debugPrint('$e');
          //ignore:use_build_context_synchronously
          ShowSnackBar().showError(context);
        }
      } else {
        debugPrint('Код неверный');
        _equalsPin.content(true);
      }
      _sendAnyRequest = false;
    }
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

  @override
  void setName(String name, String surname) {
    FocusScope.of(context).unfocus();
    _index.content(3);
  }

  @override
  Future<void> completeRegistration(bool isTrainer) async {
    if ((ModalRoute.of(context)?.settings.arguments ?? '') as String !=
        'rolePage') {
      if (!_sendAnyRequest) {
        _sendAnyRequest = true;
        try {
          await model.registration(
            name: _nameController.text,
            surname: _surnameController.text,
            code: _pinController.text,
            isTrainer: isTrainer,
          );
          await _userNotifier.saveTokens(_pinController.text);
          await _userNotifier.loginCode.updateCode(_pinController.text);
          if (_userNotifier.canUseBiometric) {
            if (_acceptBiometrics.value?.data ?? false) {
              await _userNotifier
                  .updateBiometricStorage(_firstEnter.value?.data ?? true);
              debugPrint('Биометрия сохранена');
            }
          }
          await _userNotifier.loginCode.updatePhone(_phoneController.text);
          await _userNotifier.loginCode.loadPhone();

          await model.signIn(
            phone: '${_userNotifier.loginCode.phone}'.replaceAll(' ', ''),
            password: _pinController.text,
          );
          await _userNotifier.updateUser(
            isTrainer,
            _nameController.text,
            _surnameController.text,
            _phoneController.text,
          );
          toMain();
        } on FormatException catch (e) {
          debugPrint('$e');
          ShowSnackBar().showError(context);
          _codeButtonAvailability.content(false);
        }
        _sendAnyRequest = false;
      }
    } else {
      if (!_sendAnyRequest) {
        _sendAnyRequest = true;
        try {
          await model.changeRole(
            isTrainer: isTrainer,
          );
          await _userNotifier.updateUser(
            isTrainer,
            _nameController.text,
            _surnameController.text,
            _phoneController.text,
          );
          toMain();
        } on FormatException catch (e) {
          debugPrint('$e');
          ShowSnackBar().showError(context);
          _codeButtonAvailability.content(false);
        }
        _sendAnyRequest = false;
      }
      backToSettings();
    }
  }

  @override
  void toRestorePass() {
    FocusScope.of(context).unfocus();
    // _userNotifier.removeUser();
    // _biometricEnterFlag.content(false);
    // _firstEnter.content(true);
    _index.content(0);
  }

  @override
  void toMain() {
    FocusScope.of(context).unfocus();
    coordinator.navigate(
      context,
      AppCoordinate.mainScreen,
    );
  }

  ///функция проверяющая первый ли это вход в приложение
  Future<void> firstEnterFunction() async {
    await _userNotifier.loginCode.loadCode();
    if (_userNotifier.loginCode.codeHash != null) {
      _firstEnter.content(false);
    } else {
      _firstEnter.content(true);
    }
  }

  ///
  void backToSettings() {
    coordinator.pop();
  }

  ///
  void onBiometrics() {
    _acceptBiometrics.content(!_acceptBiometrics.value!.data!);
    _userNotifier.changeBiometricLogin(_acceptBiometrics.value!.data!);
    _acceptBiometrics.content(_userNotifier.biometricLogin);
  }

  ///
  Future<void> _initIndex() async {
    _index.loading();
    await _userNotifier.loginCode.loadCode();
    await _userNotifier.tokenStorage.checkUseBiometric();
    _biometricEnterFlag.content(_userNotifier.loginCode.codeHash != null &&
        _userNotifier.canUseBiometric &&
        _userNotifier.biometricLogin);
    _firstEnter.content(_userNotifier.loginCode.codeHash == null);
    final indexCheck =
        //ignore: use_build_context_synchronously
        (ModalRoute.of(context)?.settings.arguments ?? '') as String;

    indexCheck == 'rolePage'
        ? _index.content(3)
        : (_userNotifier.loginCode.codeHash?.isNotEmpty ?? false)
            ? _index.content(1)
            : _index.content(0);
  }
}
