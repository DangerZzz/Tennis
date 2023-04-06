import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана каталога лотов
@RestApi()
abstract class UserClient {
  /// Фабрика возвращающая [UserClient]
  factory UserClient(Dio dio) = _UserClient;
}
