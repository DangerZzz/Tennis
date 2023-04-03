import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Хранилище токенов
class TokenStorage {
  ///Наличие биометрии
  static bool fingerPrint = false;

  ///Наличие биометрии
  static bool faceID = false;

  /// PIN-код
  static String? code;

  final String _key = 'TennisSecureToken';

  /// Токен
  String? get token => _token;

  String? _token;

  ///Восстановление данных о выборе биометрии для PinPad
  static Future<void> restoreBiometric() async {
    final temp = await SharedPreferences.getInstance();
    fingerPrint = temp.getBool('fingerPrint') ?? false;
    faceID = temp.getBool('faceID') ?? false;
  }

  ///Восстановление PIN-кода
  static Future<void> restoreCode() async {
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('firstRun')) {
      await const FlutterSecureStorage().delete(key: 'TennisSecretPin');
      await sp.setBool('firstRun', true);
      return;
    }
    final temp = await const FlutterSecureStorage().read(
      key: 'TennisSecretPin',
    );

    code = temp;
  }

  /// установка токена
  Future<void> setToken({required String token}) async {
    _token = token;
    await const FlutterSecureStorage().write(key: _key, value: token);
  }

  /// обновляет состояние
  Future<void> refreshAccessToken() async {
    try {
      final prefs = await const FlutterSecureStorage().read(
        key: _key,
      );
      _token = prefs.toString();
    } on FormatException catch (_) {
      await const FlutterSecureStorage().deleteAll();
    }
  }

  /// установка токена
  Future<void> deleteToken() async {
    _token = null;
    await const FlutterSecureStorage().delete(key: _key);
  }
}
