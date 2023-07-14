import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Useful
@RestApi()
abstract class UsefulPageClient {
  /// Фабрика возвращающая [UsefulPageClient]
  factory UsefulPageClient(Dio dio) = _UsefulPageClient;

  ///
  @GET('/api/advice/list')
  Future<DTO> getUsefulData(
    @Queries() Map<String, dynamic> body,
  );

  // ///
  // @GET('/api/advice/')
  // Future<DTO> usefulDataByIndex(
  //   @Path() String path,
  // );

  /// Скачивание файла
  @GET('{url}')
  Future<DTO> usefulDataByIndex(
    @Path('url') String url,
  );
}
