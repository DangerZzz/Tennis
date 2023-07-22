import 'package:biometric_storage/biometric_storage.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// Класс описывающий хранение токенов с secure storage
class TokenStorage {
  final _secureStorage = const FlutterSecureStorage();

  final _biometricStorage = BiometricStorage();

  /// access токен
  String? get accessToken => _accessToken;

  /// refresh токен
  String? get refreshToken => _refreshToken;

  ///Флаг использования биометрии
  bool get canUseBiometric => _canUseBiometric;

  ///Флаг поддержки фингерпринта
  bool get fingerprintAuth => _fingerprintSupport;

  ///Флаг поддержки фейс-айди
  bool get faceAuth => _faceIdSupport;

  var _canUseBiometric = false;
  var _fingerprintSupport = false;
  var _faceIdSupport = false;

  String? _cookieToken;
  String? _refreshToken;
  String? _accessToken;

  /// Конструктор [TokenStorage]
  TokenStorage();

  /// Установка cookie токена
  Future<void> setCookieToken(
    String cookie,
  ) async {
    _cookieToken = cookie;
  }

  /// Установка refresh токена
  Future<void> setRefreshToken(
    String refreshToken,
  ) async {
    _refreshToken = refreshToken;
  }

  /// Установка access токена
  Future<void> setAccessToken(
    String accessToken,
  ) async {
    _accessToken = accessToken;
  }

  /// Возвращает cookie токен из хранилища
  String? getCookieToken() {
    return _cookieToken;
  }

  /// Возвращает токен рефреш из хранилища
  String? getRefreshToken() {
    return _refreshToken;
  }

  /// Возвращает токен аксес из хранилища
  String? getAccessToken() {
    return _accessToken;
  }

  /// Удаление токенов
  Future<void> clearTokens() async {
    await const FlutterSecureStorage().deleteAll();
    _accessToken = null;
    _cookieToken = null;
    _refreshToken = null;
  }

  /// Сохраняет токены на устростве
  Future<void> saveTokens(String code) async {
    // // ignore: do_not_use_environment
    // const eKey = String.fromEnvironment(
    //   'tennis_secret_tokens_key',
    //   defaultValue: 'tennis_secret_tokens_key',
    // );
    // debugPrint(eKey);
    // assert(eKey.length == 32);

    final x = Uint8List.fromList([
      -107,
      -23,
      -101,
      71,
      19,
      -45,
      -126,
      -59,
      -40,
      38,
      -45,
      -85,
      -92,
      17,
      -72,
      -81
    ]);

    final key = enc.Key(x);
    final iv = enc.IV.fromUtf8(code);

    final encrypter = enc.Encrypter(enc.AES(key));

    final encryptedAccessToken = encrypter.encrypt(_accessToken!, iv: iv);
    final encryptedRefreshToken = encrypter.encrypt(_refreshToken!, iv: iv);
    final encryptedCookieToken = encrypter.encrypt(_cookieToken!, iv: iv);

    await _secureStorage.write(
      key: 'TennisAppAccessToken',
      value: encryptedAccessToken.base64,
    );

    await _secureStorage.write(
      key: 'TennisAppRefreshToken',
      value: encryptedRefreshToken.base64,
    );

    await _secureStorage.write(
      key: 'TennisAppCookieToken',
      value: encryptedCookieToken.base64,
    );
  }

  /// Загружает токены с устроства
  Future<void> loadTokens(String code) async {
    // // ignore: do_not_use_environment
    // const eKey = String.fromEnvironment('secret_tokens_key');
    // assert(eKey.length == 32);
    //
    // final key = enc.Key.fromUtf8(eKey);
    final x = Uint8List.fromList([
      -107,
      -23,
      -101,
      71,
      19,
      -45,
      -126,
      -59,
      -40,
      38,
      -45,
      -85,
      -92,
      17,
      -72,
      -81
    ]);

    final key = enc.Key(x);
    final iv = enc.IV.fromUtf8(code);

    final encrypter = enc.Encrypter(enc.AES(key));

    final encryptedAccessToken = await _secureStorage.read(
      key: 'TennisAppAccessToken',
    );
    final encryptedRefreshToken = await _secureStorage.read(
      key: 'TennisAppRefreshToken',
    );
    final encryptedCookieToken = await _secureStorage.read(
      key: 'TennisAppCookieToken',
    );

    _accessToken = encrypter.decrypt64(encryptedAccessToken!, iv: iv);
    _refreshToken = encrypter.decrypt64(encryptedRefreshToken!, iv: iv);
    _cookieToken = encrypter.decrypt64(encryptedCookieToken!, iv: iv);
  }

  /// Сохранение кода в биометрическое харнилище
  Future<void> saveCodeBiometrics(String code) async {
    final storage = await _biometricStorage.getStorage(
      'TennisLoginCode',
      forceInit: true,
      options: StorageFileInitOptions(
        authenticationValidityDurationSeconds: 1,
      ),
      promptInfo: const PromptInfo(
        iosPromptInfo: IosPromptInfo(
          accessTitle: '',
          saveTitle: '',
        ),
        androidPromptInfo: AndroidPromptInfo(
          title: 'Подтвердите использование биометрии',
          negativeButton: 'Отмена',
        ),
      ),
    );
    await storage.write(code);
    debugPrint('код сохранен');
  }

  /// получение кода из биометрического харнилища
  Future<String?> getBiometricsCode() async {
    final storage = await _biometricStorage.getStorage(
      'TennisLoginCode',
      // forceInit: true,
      options: StorageFileInitOptions(
        authenticationValidityDurationSeconds: 1,
      ),
      promptInfo: const PromptInfo(
        iosPromptInfo: IosPromptInfo(
          accessTitle: '',
          saveTitle: '',
        ),
        androidPromptInfo: AndroidPromptInfo(
          title: 'Войти в приложение',
          negativeButton: 'Отмена',
        ),
      ),
    );
    debugPrint('код прочитан');
    return await storage.read();
  }

  /// очистка кода из биометрического харнилища
  Future<void> clearBiometricsCode() async {
    await _biometricStorage.delete(
      'TennisLoginCode',
      PromptInfo.defaultValues,
    );
    debugPrint('код удален');
    return;
  }

  /// очистка кода из биометрического харнилища
  Future<void> checkUseBiometric() async {
    final auth = LocalAuthentication();
    await auth.canCheckBiometrics.then((value) async {
      if (value) {
        final biometrics = await auth.getAvailableBiometrics();
        _fingerprintSupport = biometrics.contains(BiometricType.fingerprint) ||
            biometrics.contains(BiometricType.strong);
        _faceIdSupport = biometrics.contains(BiometricType.face);
        if (_fingerprintSupport || _faceIdSupport) {
          _canUseBiometric = await _biometricStorage.canAuthenticate() ==
              CanAuthenticateResponse.success;
        }
        debugPrint('$biometrics');
      }
    });
  }
}
