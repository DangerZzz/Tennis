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
  @GET('/api/user/attachment')
  Future<DTO> getAvatarsData();

  ///
  @DELETE('{url}')
  Future<DTO> deleteAvatarData(
    @Path('url') String url,
  );

  ///
  @PATCH('{url}')
  @MultiPart()
  Future<DTO> uploadAvatar(
    @Path('url') String url,
    @Body() FormData body,
  );

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
