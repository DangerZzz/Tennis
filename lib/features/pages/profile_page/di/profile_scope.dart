import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_model.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/repository/mock/mock_profile_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/repository/profile_screen_repository.dart';

/// Интерфейс Scope для экранов фичи Profile
abstract class IProfilePageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Profile
  ProfilePageModel get profilePageModel;
}

/// Scope для оформления заказов
class ProfilePageScope implements IProfilePageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final ProfilePageClient _profilePageClient;

  late final ProfilePageModel _profilePageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  ProfilePageModel get profilePageModel => _profilePageModel;

  /// Конструткор [ProfilePageScope]
  ProfilePageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _profilePageClient = ProfilePageClient(_dio);

    _initProfilePageModel();
  }

  void _initProfilePageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockProfilePageRepository()
        : ProfilePageRepository(_profilePageClient);
    _profilePageModel = ProfilePageModel(repository, errorHandler);
  }
}
