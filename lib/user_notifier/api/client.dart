import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для модели юзера
@RestApi()
abstract class UserClient {
  /// Фабрика возвращающая [UserClient]
  factory UserClient(Dio dio) = _UserClient;

  /// Выход пользователя из системы
  @POST('/app.user.logout')
  Future<DTO> logout();
}
