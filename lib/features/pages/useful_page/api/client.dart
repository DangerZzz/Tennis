import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана Useful
@RestApi()
abstract class UsefulPageClient {
  /// Фабрика возвращающая [UsefulPageClient]
  factory UsefulPageClient(Dio dio) = _UsefulPageClient;
}
