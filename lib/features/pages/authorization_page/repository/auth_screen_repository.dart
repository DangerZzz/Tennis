import 'package:soft_weather_tennis/features/pages/authorization_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/dto/code_temp_dto.dart';

/// Репозиторий для главной
class AuthorizationPageRepository {
  final AuthorizationPageClient _authorizationPageClient;

  /// Конструктор [AuthorizationPageRepository]
  AuthorizationPageRepository(this._authorizationPageClient);

  /// Запрос на получение кода
  Future<bool>? getCode(Map<String, dynamic> body) =>
      _authorizationPageClient.getCode(body).then(
        (dto) {
          final data = CodeDtO.fromJson(dto.data as Map<String, dynamic>);

          return data.isRegistered;
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

  /// Отправка кода
  Future<void>? changeRole(Map<String, dynamic> body) =>
      _authorizationPageClient.changeRole(body).then(
        (dto) {
          return null;
        },
      );
}
