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
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getCharactersInfo();
}
