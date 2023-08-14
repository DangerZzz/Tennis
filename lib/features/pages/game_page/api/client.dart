import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Game
@RestApi()
abstract class GamePageClient {
  /// Фабрика возвращающая [GamePageClient]
  factory GamePageClient(Dio dio) = _GamePageClient;

  ///
  @GET('/api/game/history')
  Future<DTO> getTrainingsData(
    @Queries() Map<String, dynamic> body,
  );

  ///
  @GET('/api/sportsman/list')
  Future<DTO> getProPlayerData(
    @Queries() Map<String, dynamic> body,
  );

  ///
  @GET('/api/game/accesses')
  Future<DTO> getGameData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getProPlayerSearchData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getProPlayerInfoData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getStatisticsData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getTrainingData();

  ///
  @GET('/api/game/preparing')
  Future<DTO> getPreparingData(
    @Queries() Map<String, dynamic> body,
  );

  ///
  @POST('/api/game/initial')
  Future<DTO> getInitialData(
    @Body() Map<String, dynamic> body,
  );

  ///
  @POST('/api/game/qrcode')
  Future<DTO> getQRData(
    @Body() Map<String, dynamic> body,
  );

  ///
  @POST('/api/game/connect')
  Future<DTO> postConnect(
    @Body() Map<String, dynamic> body,
  );

  ///
  @POST('/api/game/start')
  Future<DTO> gameStart(
    @Header('cookie') String tokens,
  );

  ///
  @GET('/api/user')
  Future<DTO> getUserInfo();
}
