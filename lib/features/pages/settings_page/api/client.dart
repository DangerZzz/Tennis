import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент для экрана Settings
@RestApi()
abstract class SettingsPageClient {
  /// Фабрика возвращающая [SettingsPageClient]
  factory SettingsPageClient(Dio dio) = _SettingsPageClient;
}
