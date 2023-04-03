import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/authorization/authorization_page_model.dart';
import 'package:soft_weather_tennis/features/authorization/authorization_page_widget.dart';
import 'package:soft_weather_tennis/features/authorization/di/authorizarion_scope.dart';
import 'package:soft_weather_tennis/features/authorization/tools/code_text_field_tool.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/user_notifier/domain/token_storage.dart';

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

  /// Флаг отправки кода
  ListenableState<EntityState<bool>> get codeIsSend;

  /// Флаг равенства пин-кодов
  ListenableState<EntityState<bool>> get equalsPin;

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

  /// Функция установки фамилии/имени
  void setName(String name, String surname);

  /// Функция перехода на главную
  void toMain();
}

///
AuthorizationPageWidgetModel defaultAuthorizationPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IAuthorizationPageScope>();
  final appDependencies = context.read<IAppScope>();
  // final userNotifier = context.read<IUserNotifier>();
  final coordinator = appDependencies.coordinator;
  final model = scope.authorizationPageModel;
  return AuthorizationPageWidgetModel(
    model,
    coordinator: coordinator,
    // userNotifier: userNotifier,
  );
}

/// Default widget model for AuthorizationPageWidget
class AuthorizationPageWidgetModel
    extends WidgetModel<AuthorizationPageWidget, AuthorizationPageModel>
    implements IAuthorizationPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

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
  ListenableState<EntityState<bool>> get phoneButtonAvailability =>
      _phoneButtonAvailability;

  @override
  ListenableState<EntityState<bool>> get codeButtonAvailability =>
      _codeButtonAvailability;

  @override
  ListenableState<EntityState<bool>> get pinButtonAvailability =>
      _pinButtonAvailability;

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
  late EntityStateNotifier<bool> _equalsPin;

  /// Конструктор
  AuthorizationPageWidgetModel(
    AuthorizationPageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _index = EntityStateNotifier<int>();
    _index.content(1);
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
    // _codeEnter = EntityStateNotifier<String>();
    // _codeEnter.content('');
    // _acceptBiometrics = EntityStateNotifier<bool>();
    // _acceptBiometrics.content(false);
    // _loginState = EntityStateNotifier<bool>()..content(false);
  }

  @override
  Future<void> handlerField(String p) async {
    _codeButtonAvailability.content(true);
    // try {
    //   _sending.content(true);
    //   final enterCodeResponse = await model.validCode(
    //     code: p,
    //     target: _argumentHandler.getArgument(),
    //     isPhone: _argumentHandler.isPhone,
    //   );
    //   final tokens = enterCodeResponse.mapTokens;
    //   if (_userNotifier.loginSettings.codeLogin == null) {
    //     await _userNotifier.setTokens(
    //       accessToken: tokens['access_token']!,
    //       refreshToken: tokens['refresh_token']!,
    //       registrationComplete: enterCodeResponse.registrationComplete,
    //     );
    //     if (!isMounted) return;
    //
    //     //ignore: use_build_context_synchronously
    //     coordinator
    //       ..popUntilRoot()
    //     //ignore: use_build_context_synchronously
    //       ..navigate(
    //         context,
    //         AppCoordinate.authorizationActivationCode,
    //       );
    //   } else {
    //     await _userNotifier.setTokensAndDio(
    //       accessToken: tokens['access_token']!,
    //       refreshToken: tokens['refresh_token']!,
    //       registrationComplete: enterCodeResponse.registrationComplete,
    //     );
    //     await _userNotifier.updateUser();
    //
    //     ///Проверка на права пользователя
    //     if (!_userNotifier.ruleAccept) {
    //       //ignore: use_build_context_synchronously
    //       coordinator.navigate(
    //         context,
    //         AppCoordinate.noAuctionRoleSelectedScreen,
    //         replaceCurrentCoordinate: true,
    //       );
    //       return;
    //     }
    //
    //     ///Проверка на завершенность регистрации
    //     if (!_userNotifier.registrationComplete) {
    //       //ignore: use_build_context_synchronously
    //       coordinator.navigate(
    //         context,
    //         AppCoordinate.incompleteRegistrationScreen,
    //         replaceCurrentCoordinate: true,
    //       );
    //       return;
    //     }
    //     coordinator.popUntilRoot();
    //   }
    // } on FormatException catch (e) {
    //   flushbar.show(
    //     context,
    //     msgText:
    //     e.message.isNotEmpty ? e.message : appLocalization.httpErrors(''),
    //   );
    //   try {
    //     await _userNotifier.removeUser();
    //   } on FormatException catch (_) {
    //     // возврат на страницу ввода телефона / email
    //     coordinator.pop(); //todo: сделать редирект с ошибкой
    //     return;
    //   }
    //   _sending.content(false);
    //   return;
    // }
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
  void nameEnterButtonAvailabilityFunction() {
    if (_nameController.text.length >= 2 &&
        _surnameController.text.length >= 2) {
      _nameButtonAvailability.content(true);
    } else {
      _nameButtonAvailability.content(false);
    }
  }

  @override
  void getCode(String code) {
    _codeIsSend.content(true);
  }

  @override
  void sendCode(String code) {
    //api
    _index.content(1);
  }

  @override
  Future<void> setPin(String code) async {
    await TokenStorage.restoreCode();
    final bytes = utf8.encode(code);
    final digest = md5.convert(bytes);
    if (TokenStorage.code == null) {
      TokenStorage.code = code;
      await const FlutterSecureStorage()
          .write(key: 'TennisSecretPin', value: '$digest');
      debugPrint('Код сохранен');
      _index.content(2);
    }

    ///
    else {
      final temp =
          await const FlutterSecureStorage().read(key: 'TennisSecretPin');
      if (temp == digest.toString()) {
        debugPrint('Код совпал');
        _equalsPin.content(false);

        _index.content(2);
      } else {
        _equalsPin.content(true);
        debugPrint('Код не совпал');

        // showErrorFlushBar(context, 'Неверный PIN-код');
      }
    }
    //api
  }

  @override
  void setName(String name, String surname) {
    //api
    _index.content(3);
  }

  @override
  void toMain() {
    coordinator.navigate(
      context,
      AppCoordinate.mainScreen,
    );
  }
}
