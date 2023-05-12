import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/characteristics_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/mock/mock_settings_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';

/// Интерфейс Scope для экранов фичи Settings
abstract class ICharacteristicsPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Settings
  CharacteristicsPageModel get characteristicsPageModel;
}

/// Scope для оформления заказов
class CharacteristicsPageScope implements ICharacteristicsPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final SettingsPageClient _settingsPageClient;

  late final CharacteristicsPageModel _characteristicsPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  CharacteristicsPageModel get characteristicsPageModel =>
      _characteristicsPageModel;

  /// Конструткор [CharacteristicsPageScope]
  CharacteristicsPageScope({
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
    _characteristicsPageModel =
        CharacteristicsPageModel(repository, errorHandler);
  }
}
