import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана Profile
@RestApi()
abstract class ProfilePageClient {
  /// Фабрика возвращающая [ProfilePageClient]
  factory ProfilePageClient(Dio dio) = _ProfilePageClient;
}
