import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Сущность описывающая хранение и получение кода, установленным пользователем
/// для авторизации
class LoginCode {
  final _secureStorage = const FlutterSecureStorage();

  /// Валидный хэш кода для авторизации пользователя
  String? get codeHash => _codeHash;

  ///
  String? get code => _currentCode;

  String? _codeHash;

  String? _currentCode;

  /// Констурктор [LoginCode]
  LoginCode() {
    loadCode();
  }

  /// Установка нового кода
  Future<void> updateCode(String newCode) async {
    _currentCode = newCode;
    // ignore: do_not_use_environment
    final key = utf8.encode(const String.fromEnvironment('secret_storage_key'));
    final bytes = utf8.encode(newCode);

    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    final hash = digest.toString();

    _codeHash = hash;
    await _secureStorage.write(
      key: 'TennisLoginCode',
      value: hash,
    );
  }

  /// Обновление [codeHash] из SecureStorage
  Future<void> loadCode() async {
    try {
      final prefs = await _secureStorage.read(
        key: 'TennisLoginCode',
      );
      _codeHash = prefs;
    } on FormatException catch (_) {
      await _secureStorage.delete(
        key: 'TennisLoginCode',
      );
    }
  }

  /// Очистка [codeHash] и из SecureStorage
  Future<void> clear() async {
    _codeHash = null;
    await _secureStorage.delete(
      key: 'TennisLoginCode',
    );
  }

  /// Сравнение существующего хэша кода с передаваемой строкой
  bool compare(String code) {
    // ignore: do_not_use_environment
    final key = utf8.encode(const String.fromEnvironment('secret_storage_key'));
    final bytes = utf8.encode(code);

    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    final hash = digest.toString();
    return hash == _codeHash;
  }
}
