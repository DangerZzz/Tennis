import 'package:soft_weather_tennis/features/pages/authorization_page/api/client.dart';

/// Репозиторий для главной
class AuthorizationPageRepository {
  final AuthorizationPageClient _authorizationPageClient;

  /// Конструктор [AuthorizationPageRepository]
  AuthorizationPageRepository(this._authorizationPageClient);

  /// Запрос на получение кода
  Future<void>? getCode(Map<String, dynamic> body) =>
      _authorizationPageClient.getCode(body).then(
        (dto) {
          return null;
        },
      );

  /// Отправка кода
  Future<void>? sendCode(Map<String, dynamic> body) =>
      _authorizationPageClient.sendCode(body).then(
        (dto) {
          return null;
        },
      );

  /// Отправка кода
  Future<void>? registration(Map<String, dynamic> body) =>
      _authorizationPageClient.registration(body).then(
        (dto) {
          return null;
        },
      );

  /// Отправка кода
  Future<void>? signIn(Map<String, dynamic> body) =>
      _authorizationPageClient.signIn(body).then(
        (dto) {
          return null;
        },
      );

  /// Отправка кода
  Future<void>? recovery(Map<String, dynamic> body) =>
      _authorizationPageClient.recovery(body).then(
        (dto) {
          return null;
        },
      );
}
