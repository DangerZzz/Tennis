import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/cupertino.dart';
// import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// Класс описывающий хранение токенов с secure storage
class TokenStorage {
  final _secureStorage = const FlutterSecureStorage();

  final _biometricStorage = BiometricStorage();

  // /// access токен
  // String? get accessToken => _accessToken;

  ///
  bool get canUseBiometric => _canUseBiometric;

  ///
  bool get fingerprintAuth => _fingerprintSupport;

  ///
  bool get faceAuth => _faceIdSupport;

  var _canUseBiometric = false;
  var _fingerprintSupport = false;
  var _faceIdSupport = false;

  // String? _accessToken;

  /// Конструктор [TokenStorage] проверяет доступность биометрии
  TokenStorage() {
    final auth = LocalAuthentication();
    auth.canCheckBiometrics.then((value) async {
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

  // /// Возвращает токен cookie из хранилища
  // String? getAccessToken() {
  //   return _accessToken;
  // }

  // /// Установка session токена
  // Future<void> setAccessToken(String token) async {
  //   _accessToken = token;
  // }

  /// Установка токена cookie
  Future<void> clearTokens() async {
    await const FlutterSecureStorage().deleteAll();
    // _accessToken = null;
  }

  // /// Сохраняет токены на устростве
  // Future<void> saveTokens(String code) async {
  //   // ignore: do_not_use_environment
  //   const eKey = String.fromEnvironment('secret_tokens_key');
  //   assert(eKey.length == 32);
  //
  //   final key = enc.Key.fromUtf8(eKey);
  //   final iv = enc.IV.fromUtf8(code);
  //
  //   final encrypter = enc.Encrypter(enc.AES(key));
  //
  //   final encryptedAccessToken = encrypter.encrypt(_accessToken!, iv: iv);
  //
  //   await _secureStorage.write(
  //     key: 'TennisAccessToken',
  //     value: encryptedAccessToken.base64,
  //   );
  //
  // }

  // /// Загруает токены с устроства
  // Future<void> loadTokens(String code) async {
  //   // ignore: do_not_use_environment
  //   const eKey = String.fromEnvironment('secret_tokens_key');
  //   assert(eKey.length == 32);
  //
  //   final key = enc.Key.fromUtf8(eKey);
  //   final iv = enc.IV.fromUtf8(code);
  //
  //   final encrypter = enc.Encrypter(enc.AES(key));
  //
  //   final encryptedAccessToken = await _secureStorage.read(
  //     key: 'TennisAccessToken',
  //   );
  //   _accessToken = encrypter.decrypt64(encryptedAccessToken!, iv: iv);
  // }

  /// сохранение кода в биометрическое харнилище
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
  Future<String> getBiometricsCode() async {
    final storage = await _biometricStorage.getStorage(
      'TennisLoginCode',
      // forceInit: true,
      options: StorageFileInitOptions(
        authenticationValidityDurationSeconds: 10,
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
    return (await storage.read())!;
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
}
