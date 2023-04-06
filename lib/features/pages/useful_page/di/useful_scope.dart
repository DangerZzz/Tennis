import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/mock/mock_useful_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/useful_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_model.dart';

/// Интерфейс Scope для экранов фичи Useful
abstract class IUsefulPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Useful
  UsefulPageModel get usefulPageModel;
}

/// Scope для оформления заказов
class UsefulPageScope implements IUsefulPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final UsefulPageClient _usefulPageClient;

  late final UsefulPageModel _usefulPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  UsefulPageModel get usefulPageModel => _usefulPageModel;

  /// Конструткор [UsefulPageScope]
  UsefulPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _usefulPageClient = UsefulPageClient(_dio);

    _initUsefulPageModel();
  }

  void _initUsefulPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockUsefulPageRepository()
        : UsefulPageRepository(_usefulPageClient);
    _usefulPageModel = UsefulPageModel(repository, errorHandler);
  }
}
