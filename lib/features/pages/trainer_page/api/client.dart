import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана TrainerPage
@RestApi()
abstract class TrainerPageClient {
  /// Фабрика возвращающая [TrainerPageClient]
  factory TrainerPageClient(Dio dio) = _TrainerPageClient;

  ///
  @POST('/api/game/connect')
  Future<DTO> sendQrData(
    @Body() Map<String, dynamic> body,
  );

  ///
  @GET('/api/user')
  Future<DTO> getUserInfo();
}
