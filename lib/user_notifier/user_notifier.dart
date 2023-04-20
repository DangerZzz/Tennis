import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/user_notifier/api/client.dart';
import 'package:soft_weather_tennis/user_notifier/di/user_scope.dart';
import 'package:soft_weather_tennis/user_notifier/domain/login_code.dart';
import 'package:soft_weather_tennis/user_notifier/domain/token_storage.dart';
import 'package:soft_weather_tennis/user_notifier/domain/user.dart';
import 'package:soft_weather_tennis/user_notifier/repository/mock/mock_user_repository.dart';
import 'package:soft_weather_tennis/user_notifier/repository/user_repository.dart';

/// Обертка над [User]
class UserNotifier extends ChangeNotifier implements IUserNotifier {
  final _tokenStorage = TokenStorage();
  final _loginCode = LoginCode();

  final ErrorHandler _errorHandler;

  late final UserRepository _repository;

  final Dio _dio;

  /// Вход по отпечатку
  bool get biometricLogin => _biometricLogin;

  /// текущий уровень сложности
  num get currentLevel => _currentLevel;

  /// функция изменения уровня сложности
  set currentLevel(num level) {
    _currentLevel = level;
  }

  /// текущий уровень сложности
  String get currentComplexity => _currentComplexity;

  /// функция изменения уровня сложности
  set currentComplexity(String complexity) {
    _currentComplexity = complexity;
  }

  // ///email пользователя
  // @override
  // String get email => _user?.email ?? '';

  ///id пользователя
  @override
  String get id => _user?.id ?? '';

  ///имя пользователя
  @override
  String get name => _user?.name ?? '';

  ///фамилия пользователя
  @override
  String get surname => _user?.surname ?? '';

  @override
  String get phone => _user?.phone ?? '';

  @override
  bool get isTrainer => _user?.isTrainer ?? false;

  /// Залогинен ли пользователь
  @override
  bool get isLogin => _user != null;

  @override
  bool get canUseBiometric => _tokenStorage.canUseBiometric;

  @override
  bool get canUseFaceID => _tokenStorage.faceAuth;

  @override
  bool get canUseFingerprint => _tokenStorage.fingerprintAuth;

  @override
  LoginCode get loginCode => _loginCode;

  User? _user;

  /// Вход по отпечатку
  late bool _biometricLogin;

  ///
  late num _currentLevel = 1;

  ///
  late String _currentComplexity = '';

  /// Конструктор
  UserNotifier({required Dio dio, required ErrorHandler errorHandler})
      : _dio = dio,
        _errorHandler = errorHandler {
    loginCode.loadCode();
    _loadLoginSettings();
    _repository = Environment<AppConfig>.instance().useMock
        ? MockUserRepository()
        : UserRepository(UserClient(_dio));
  }

  /// Подзрузка данных пользователя + обновление
  @override
  Future<void> updateUser(
    bool isTrainer,
    String id,
    String name,
    String surname,
    String phone,
  ) async {
    late final User user;
    // await ExceptionHandler.shellException(
    //   () async => user = await _repository.getUserInfo(),
    // );
    _user = User(
      id: id,
      phone: phone,
      name: name,
      isTrainer: isTrainer,
      surname: surname,
    );
    // await _loginSettings.changeAccountName(fio);
    notifyListeners();
  }

  /// Очистка данных пользователя - logout
  @override
  Future<void> removeUser() async {
    // try {
    //   await _repository.logout();
    // } on Exception catch (_) {}
    // await _loginSettings.clearSettingsLogin();
    await _loginCode.clear();
    await _tokenStorage.clearTokens();
    await _tokenStorage.clearBiometricsCode();
    // _clearDioTokens();
    _user = null;
    // _registrationComplete = null;
    notifyListeners();
  }

  // @override
  // Future<Map<String, dynamic>> updateDio({String? header}) async {
  //   final accessToken = _tokenStorage.getAccessToken();
  //   final refreshToken = _tokenStorage.getRefreshToken();
  //   final bx = _tokenStorage.getBxToken();
  //   final phpSid = _tokenStorage.getPHPSidToken();
  //   if (accessToken == null ||
  //       refreshToken == null ||
  //       bx == null ||
  //       phpSid == null) {
  //     return <String, dynamic>{};
  //   }
  //   late final String prev;
  //   if (header == null) {
  //     prev = (_dio.options.headers['cookie'] != null)
  //         ? _dio.options.headers['cookie'] as String
  //         : '';
  //   } else {
  //     prev = header;
  //   }
  //   final headers = <String, dynamic>{
  //     'cookie':
  //         '$phpSid; access_token=$accessToken; refresh_token=$refreshToken',
  //     'X-BX-Csrf-Token': bx,
  //   };
  //   _dio.options.headers.addAll(headers);
  //   Downloader.instance.headers = headers;
  //   WebSockets.init(_errorHandler, headers: headers);
  //   return headers;
  // }
  //
  // @override
  // Future<void> setTokensFromHeaders() async {
  //   await _tokenStorage
  //       .setBxToken(_dio.options.headers['X-BX-Csrf-Token'] as String);
  //   final cookie =
  //       (_dio.options.headers['cookie'] as String).split(';').firstWhere(
  //             (element) => element.contains('PHPSESSID'),
  //           );
  //   await _tokenStorage.setPHPSidToken(cookie);
  // }
  //
  // @override
  // Future<void> setTokens({
  //   required String accessToken,
  //   required String refreshToken,
  //   bool? registrationComplete,
  // }) async {
  //   await _tokenStorage.setAccessToken(accessToken);
  //   await _tokenStorage.setRefreshToken(refreshToken);
  //   await _tokenStorage
  //       .setBxToken(_dio.options.headers['X-BX-Csrf-Token'] as String);
  //   final cookie = (_dio.options.headers['cookie'] as String).split(';')[0];
  //   await _tokenStorage.setPHPSidToken(cookie);
  //   _registrationComplete ??= registrationComplete;
  // }
  //
  // @override
  // Future<void> setTokensAndDio({
  //   required String accessToken,
  //   required String refreshToken,
  //   bool? registrationComplete,
  // }) async {
  //   await _tokenStorage.setAccessToken(accessToken);
  //   await _tokenStorage.setRefreshToken(refreshToken);
  //   if (_dio.options.headers['X-BX-Csrf-Token'] != null) {
  //     await _tokenStorage.setBxToken(
  //       _dio.options.headers['X-BX-Csrf-Token'] as String,
  //     );
  //   }
  //   final prev = (_dio.options.headers['cookie'] != null)
  //       ? _dio.options.headers['cookie'] as String
  //       : '';
  //   await _tokenStorage.setPHPSidToken(prev);
  //   final headers = <String, dynamic>{
  //     'cookie': '$prev access_token=$accessToken; refresh_token=$refreshToken',
  //   };
  //   _dio.options.headers.addAll(headers);
  //   Downloader.instance.headers = headers;
  //   WebSockets.init(_errorHandler, headers: headers);
  //   _registrationComplete ??= registrationComplete;
  // }
  //
  // @override
  // Future<void> saveTokens() async {
  //   await _tokenStorage.saveTokens(_loginCode.code!);
  // }
  //
  // @override
  // Future<void> loadTokens() async {
  //   await _tokenStorage.loadTokens(_loginCode.code!);
  // }

  @override
  Future<void> updateBiometricStorage(bool init) async {
    await _tokenStorage.saveCodeBiometrics(_loginCode.code!);
  }

  @override
  Future<void> authorizeBiometrics() async {
    final code = await _tokenStorage.getBiometricsCode();
    await _loginCode.updateCode(code);
  }

  /// Установка флага входа по коду
  Future<void> changeBiometricLogin(bool isBiometric) async {
    _biometricLogin = isBiometric;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricLogin', _biometricLogin);
    notifyListeners();
  }

  Future<void> _loadLoginSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final biometricLoginPref = prefs.getBool('biometricLogin');
    // final codeLoginPref = prefs.getInt('codeLoginState');
    // final accountName = prefs.getString('accountName');
    _biometricLogin = biometricLoginPref ?? false;
    // _codeLogin =
    // (codeLoginPref == null) ? null : CodeState.values[codeLoginPref];
    // _accountName = accountName;
  }

//
// void _clearDioTokens() {
//   _dio.options.headers
//     ..remove('cookie')
//     ..remove('X-BX-Csrf-Token');
// }
//
// Future<void> _getSessionTokens() async {
//   final tokens = await _repository.getSession();
//   _dio.options
//     ..headers['cookie'] = tokens.sessionToken
//     ..headers['X-BX-Csrf-Token'] = '${tokens.bxSessionToken};';
// }
}
