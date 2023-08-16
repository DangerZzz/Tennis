import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Лучшие
@RestApi()
abstract class BestPageClient {
  /// Фабрика возвращающая [BestPageClient]
  factory BestPageClient(Dio dio) = _BestPageClient;

  ///Получение данных страницы
  @GET('/api/gallery/list')
  Future<DTO> getBestListData();
}
