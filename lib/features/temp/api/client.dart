import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана temp
@RestApi()
abstract class TempScreenClient {
  /// Фабрика возвращающая [TempScreenClient]
  factory TempScreenClient(Dio dio) = _TempScreenClient;
}
