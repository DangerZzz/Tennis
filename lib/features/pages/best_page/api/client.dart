import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана Лучшие
@RestApi()
abstract class BestPageClient {
  /// Фабрика возвращающая [BestPageClient]
  factory BestPageClient(Dio dio) = _BestPageClient;
}
