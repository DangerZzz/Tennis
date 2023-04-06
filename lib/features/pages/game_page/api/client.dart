import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана Game
@RestApi()
abstract class GamePageClient {
  /// Фабрика возвращающая [GamePageClient]
  factory GamePageClient(Dio dio) = _GamePageClient;
}
