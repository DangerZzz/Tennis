import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана Rating
@RestApi()
abstract class RatingPageClient {
  /// Фабрика возвращающая [RatingPageClient]
  factory RatingPageClient(Dio dio) = _RatingPageClient;
}
