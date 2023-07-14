import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Profile
@RestApi()
abstract class ProfilePageClient {
  /// Фабрика возвращающая [ProfilePageClient]
  factory ProfilePageClient(Dio dio) = _ProfilePageClient;

  ///
  @GET('/api/user')
  Future<DTO> getUserInfo();

  ///
  @GET('/api/user')
  Future<DTO> getInformationData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getGameData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getStatisticsData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getTrainingData();

  ///
  @GET('/order/{cityCode}/deleteCart')
  Future<DTO> getAchievementsData();
}
