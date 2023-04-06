import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_model.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/repository/auth_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/repository/mock/mock_auth_screen_repositoy.dart';

/// Интерфейс Scope для экранов фичи Authorization
abstract class IAuthorizationPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Authorization
  AuthorizationPageModel get authorizationPageModel;
}

/// Scope для оформления заказов
class AuthorizationPageScope implements IAuthorizationPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final AuthorizationPageClient _authorizationPageClient;

  late final AuthorizationPageModel _authorizationPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  AuthorizationPageModel get authorizationPageModel => _authorizationPageModel;

  /// Конструткор [AuthorizationPageScope]
  AuthorizationPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _authorizationPageClient = AuthorizationPageClient(_dio);

    _initAuthorizationPageModel();
  }

  void _initAuthorizationPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockAuthorizationPageRepository()
        : AuthorizationPageRepository(_authorizationPageClient);
    _authorizationPageModel = AuthorizationPageModel(repository, errorHandler);
  }
}
