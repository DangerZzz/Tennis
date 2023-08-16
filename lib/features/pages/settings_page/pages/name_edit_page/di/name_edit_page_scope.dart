import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page/name_edit_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/mock/mock_settings_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';

/// Интерфейс Scope для экранов фичи Settings
abstract class INameEditPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Settings
  NameEditPageModel get nameEditPageModel;
}

/// Scope для страницы редактирования имени
class NameEditPageScope implements INameEditPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final SettingsPageClient _settingsPageClient;

  late final NameEditPageModel _nameEditPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  NameEditPageModel get nameEditPageModel => _nameEditPageModel;

  /// Конструткор [NameEditPageScope]
  NameEditPageScope({
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
    _nameEditPageModel = NameEditPageModel(repository, errorHandler);
  }
}
