import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Settings
@RestApi()
abstract class SettingsPageClient {
  /// Фабрика возвращающая [SettingsPageClient]
  factory SettingsPageClient(Dio dio) = _SettingsPageClient;

  ///
  @GET('/api/user')
  Future<DTO> getCharactersInfo();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getAvatarsData();

  ///
  @PATCH('/api/user/name')
  Future<DTO> changeName(
    @Body() Map<String, dynamic> body,
  );

  ///
  @PATCH('/api/user/characteristics')
  Future<DTO> editCharactersInfo(
    @Body() Map<String, dynamic> body,
  );

  ///
  @POST('/api/auth/logout')
  Future<DTO> exit();
}
