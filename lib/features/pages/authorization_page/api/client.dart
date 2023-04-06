import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soft_weather_tennis/dto/dto.dart';

part 'client.g.dart';

/// Клиент для экрана Authorization
@RestApi()
abstract class AuthorizationPageClient {
  /// Фабрика возвращающая [AuthorizationPageClient]
  factory AuthorizationPageClient(Dio dio) = _AuthorizationPageClient;
}
