import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Rating
@RestApi()
abstract class RatingPageClient {
  /// Фабрика возвращающая [RatingPageClient]
  factory RatingPageClient(Dio dio) = _RatingPageClient;

  /// Получение данных рейтинга
  @GET('/api/rating/list')
  Future<DTO> getRatingList(
    @Queries() Map<String, dynamic> body,
  );
}
