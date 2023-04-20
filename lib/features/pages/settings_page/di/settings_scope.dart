import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/mock/mock_settings_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_model.dart';

/// Интерфейс Scope для экранов фичи Settings
abstract class ISettingsPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Settings
  SettingsPageModel get settingsPageModel;
}

/// Scope для оформления заказов
class SettingsPageScope implements ISettingsPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final SettingsPageClient _settingsPageClient;

  late final SettingsPageModel _settingsPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  SettingsPageModel get settingsPageModel => _settingsPageModel;

  /// Конструткор [SettingsPageScope]
  SettingsPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _settingsPageClient = SettingsPageClient(_dio);

    _initSettingsPageModel();
  }

  void _initSettingsPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockSettingsPageRepository()
        : SettingsPageRepository(_settingsPageClient);
    _settingsPageModel = SettingsPageModel(repository, errorHandler);
  }
}
