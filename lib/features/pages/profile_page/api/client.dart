import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Profile
@RestApi()
abstract class ProfilePageClient {
  /// Фабрика возвращающая [ProfilePageClient]
  factory ProfilePageClient(Dio dio) = _ProfilePageClient;

  /// Получение данных пользователя
  @GET('/api/user')
  Future<DTO> getUserInfo();

  /// Получение данных вкладки "информация"
  @GET('/api/user')
  Future<DTO> getInformationData();

  ///Получение данных вкладки "игра"
  @GET('/api/game/accesses')
  Future<DTO> getGameData();

  ///Получение данных вкладки "статистика"
  @GET('/api/game/history')
  Future<DTO> getStatisticsData(
    @Queries() Map<String, dynamic> body,
  );

  ///Получение данных о тренировке
  @GET('{url}')
  Future<DTO> getTrainingData(
    @Path('url') String url,
  );

  ///Получение списка достижений
  @GET('/api/trophy/list')
  Future<DTO> getAchievementsData(
      // @Queries() Map<String, dynamic> body,
      );
}
