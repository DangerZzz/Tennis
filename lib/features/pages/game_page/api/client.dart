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
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getGameData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getProPlayerData();

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
}
