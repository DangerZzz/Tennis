import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Функция реализующая очистку secure storage при первом запуске приложения
/// после установки
Future<void> clearSecureStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final isClear = prefs.getBool('clearSecureStorage');
  if (isClear == null) {
    await const FlutterSecureStorage().deleteAll();
    await prefs.setBool('clearSecureStorage', true);
  }
}
