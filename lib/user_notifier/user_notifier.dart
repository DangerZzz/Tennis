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

  ///имя пользователя
  @override
  String get name => _user?.name ?? '';

  ///фамилия пользователя
  @override
  String get surname => _user?.surname ?? '';

  ///телефон пользователя
  @override
  String get phone => _user?.phone ?? '';

  ///роль пользователя
  @override
  bool get isTrainer => _user?.isTrainer ?? false;

  /// Залогинен ли пользователь
  @override
  bool get isLogin => _user != null;

  ///флаг использования биометрии
  @override
  bool get canUseBiometric => _tokenStorage.canUseBiometric;

  ///флаг использования фейс айди
  @override
  bool get canUseFaceID => _tokenStorage.faceAuth;

  ///флаг использования отпечатка пальца
  @override
  bool get canUseFingerprint => _tokenStorage.fingerprintAuth;

  @override
  LoginCode get loginCode => _loginCode;

  User? _user;

  /// Вход по отпечатку
  late bool _biometricLogin;

  /// текущий уровень сложности
  late num _currentLevel = 1;

  /// текущий уровень игры
  late String _currentComplexity = '';

  /// Конструктор
  UserNotifier({required Dio dio, required ErrorHandler errorHandler})
      : _dio = dio,
        _errorHandler = errorHandler {
    loginCode.loadCode();
    loadLoginSettings();
    _repository = Environment<AppConfig>.instance().useMock
        ? MockUserRepository()
        : UserRepository(UserClient(_dio));
  }

  /// Подзрузка данных пользователя + обновление
  @override
  Future<void> updateUser(
    bool isTrainer,
    String name,
    String surname,
    String phone,
  ) async {
    late final User user;
    // await ExceptionHandler.shellException(
    //   () async => user = await _repository.getUserInfo(),
    // );
    _user = User(
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

  ///Сохранение токенов
  @override
  Future<void> saveTokens(String code) async {
    await _tokenStorage.saveTokens(code);
  }

  ///Загрузка токенов
  @override
  Future<void> loadTokens(String code) async {
    await _tokenStorage.loadTokens(code);
  }

  ///Получение токенов
  @override
  Future<String> getTokens() async {
    final token = '${_tokenStorage.getRefreshToken()?.split(';')[0]};'
        '${_tokenStorage.getAccessToken()?.split(';')[0]};'
        '${_tokenStorage.getCookieToken()?.split(';')[0]};';
    return token;
  }

  @override
  Future<void> setCookieToken() async {
    final cookie = _dio.options.headers['cookie'] as String;
    await _tokenStorage.setCookieToken(cookie);
  }

  @override
  Future<void> setAccessToken(String access) async {
    final newAccess = access.split(';')[0];
    await _tokenStorage.setAccessToken(newAccess);
  }

  @override
  Future<void> setRefreshToken(String refresh) async {
    final newRefresh = refresh.split(';')[0];
    await _tokenStorage.setRefreshToken(newRefresh);
  }

  @override
  Future<void> updateBiometricStorage(bool init) async {
    await _tokenStorage.saveCodeBiometrics(_loginCode.code!);
  }

  @override
  Future<void> authorizeBiometrics() async {
    final code = await _tokenStorage.getBiometricsCode();
    if (code != null) {
      await _loginCode.updateCode(code);
    }
  }

  /// Установка флага входа по коду
  Future<void> changeBiometricLogin(bool isBiometric) async {
    _biometricLogin = isBiometric;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricLogin', _biometricLogin);
    notifyListeners();
  }

  Future<void> loadLoginSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final biometricLoginPref = prefs.getBool('biometricLogin');
    _biometricLogin = biometricLoginPref ?? false;
  }
}
