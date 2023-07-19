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
  @GET('/api/game/accesses')
  Future<DTO> getGameData();

  ///
  @GET('/api/game/history')
  Future<DTO> getStatisticsData(
    @Queries() Map<String, dynamic> body,
  );

  ///
  @GET('{url}')
  Future<DTO> getTrainingData(
    @Path('url') String url,
  );

  ///
  @GET('/api/trophy/list')
  Future<DTO> getAchievementsData(
      // @Queries() Map<String, dynamic> body,
      );
}
