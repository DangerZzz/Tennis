import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Settings
@RestApi()
abstract class SettingsPageClient {
  /// Фабрика возвращающая [SettingsPageClient]
  factory SettingsPageClient(Dio dio) = _SettingsPageClient;

  /// Получение данных пользователя
  @GET('/api/user')
  Future<DTO> getCharactersInfo();

  /// Получение данных изображений
  @GET('/api/user/attachment')
  Future<DTO> getAvatarsData();

  /// Удаление изображения
  @DELETE('{url}')
  Future<DTO> deleteAvatarData(
    @Path('url') String url,
  );

  ///Загрузка изображения
  @PATCH('{url}')
  @MultiPart()
  Future<DTO> uploadAvatar(
    @Path('url') String url,
    @Body() FormData body,
  );

  ///Изменение имени
  @PATCH('/api/user/name')
  Future<DTO> changeName(
    @Body() Map<String, dynamic> body,
  );

  ///Изменение характеристик
  @PATCH('/api/user/characteristics')
  Future<DTO> editCharactersInfo(
    @Body() Map<String, dynamic> body,
  );

  ///Выход
  @POST('/api/auth/logout')
  Future<DTO> exit();
}
