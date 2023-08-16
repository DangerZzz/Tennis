import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Authorization
@RestApi()
abstract class AuthorizationPageClient {
  /// Фабрика возвращающая [AuthorizationPageClient]
  factory AuthorizationPageClient(Dio dio) = _AuthorizationPageClient;

  /// Получение кода авторизации
  @POST('/api/code')
  Future<DTO> getCode(
    @Body() Map<String, dynamic> body,
  );

  /// Отправка проверочного кода по СМС
  @POST('/api/code/verify')
  Future<DTO> sendCode(
    @Body() Map<String, dynamic> body,
  );

  /// Регистрация нового пользователя
  @POST('/api/auth/signup')
  Future<DTO> registration(
    @Body() Map<String, dynamic> body,
  );

  /// Авторизация
  @POST('/api/auth/signin')
  Future<DTO> signIn(
    @Body() Map<String, dynamic> body,
  );

  /// Восстановление пароля
  @POST('/api/auth/recovery')
  Future<DTO> recovery(
    @Body() Map<String, dynamic> body,
  );

  /// Изменение роли
  @PATCH('/api/user/role')
  Future<DTO> changeRole(
    @Body() Map<String, dynamic> body,
  );
}
