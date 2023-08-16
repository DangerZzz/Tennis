import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/pages/useful_full_info_page/useful_full_info_page_model.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/mock/mock_useful_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/useful_screen_repository.dart';

/// Интерфейс Scope для экранов фичи Useful
abstract class IUsefulFullInfoPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Useful
  UsefulFullInfoPageModel get usefulFullInfoPageModel;
}

/// Scope для страницы о полезном
class UsefulFullInfoPageScope implements IUsefulFullInfoPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final UsefulPageClient _usefulPageClient;

  late final UsefulFullInfoPageModel _usefulFullInfoPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  UsefulFullInfoPageModel get usefulFullInfoPageModel =>
      _usefulFullInfoPageModel;

  /// Конструткор [UsefulFullInfoPageScope]
  UsefulFullInfoPageScope({
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
    _usefulFullInfoPageModel =
        UsefulFullInfoPageModel(repository, errorHandler);
  }
}
