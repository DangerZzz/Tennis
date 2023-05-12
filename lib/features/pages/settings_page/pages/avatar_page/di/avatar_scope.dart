import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/mock/mock_settings_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';

/// Интерфейс Scope для экранов фичи Settings
abstract class IAvatarPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Settings
  AvatarPageModel get avatarModel;
}

/// Scope для оформления заказов
class AvatarPageScope implements IAvatarPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final SettingsPageClient _settingsPageClient;

  late final AvatarPageModel _avatarModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  AvatarPageModel get avatarModel => _avatarModel;

  /// Конструткор [AvatarPageScope]
  AvatarPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _settingsPageClient = SettingsPageClient(_dio);

    _initAvatarPageModel();
  }

  void _initAvatarPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockSettingsPageRepository()
        : SettingsPageRepository(_settingsPageClient);
    _avatarModel = AvatarPageModel(repository, errorHandler);
  }
}
