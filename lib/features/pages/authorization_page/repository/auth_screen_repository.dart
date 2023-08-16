import 'package:soft_weather_tennis/features/pages/authorization_page/api/client.dart';

/// Репозиторий для авторизации
class AuthorizationPageRepository {
  final AuthorizationPageClient _authorizationPageClient;

  /// Конструктор [AuthorizationPageRepository]
  AuthorizationPageRepository(this._authorizationPageClient);

  /// Запрос на получение кода
  Future<void>? getCode(Map<String, dynamic> body) =>
      _authorizationPageClient.getCode(body).then(
        (dto) {
          return null;
          //
          // final data = CodeDtO.fromJson(dto.data as Map<String, dynamic>);
          //
          // return Code(
          //   code: data.code,
          //   isRegistered: data.isRegistered,
          // );
        },
      );

  /// Отправка кода
  Future<void>? sendCode(Map<String, dynamic> body) =>
      _authorizationPageClient.sendCode(body).then(
        (dto) {
          return null;
        },
      );

  /// Регистрация
  Future<void>? registration(Map<String, dynamic> body) =>
      _authorizationPageClient.registration(body).then(
        (dto) {
          return null;
        },
      );

  /// Авторизация
  Future<void>? signIn(Map<String, dynamic> body) =>
      _authorizationPageClient.signIn(body).then(
        (dto) {
          return null;
        },
      );

  /// Восстановление пароля
  Future<void>? recovery(Map<String, dynamic> body) =>
      _authorizationPageClient.recovery(body).then(
        (dto) {
          return null;
        },
      );

  /// Изменение роли
  Future<void>? changeRole(Map<String, dynamic> body) =>
      _authorizationPageClient.changeRole(body).then(
        (dto) {
          return null;
        },
      );
}
