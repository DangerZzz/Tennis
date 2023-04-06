import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/best_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_model.dart';
import 'package:soft_weather_tennis/features/pages/best_page/repository/best_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/best_page/repository/mock/mock_best_screen_repositoy.dart';

/// Интерфейс Scope для экранов фичи Best
abstract class IBestPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Best
  BestPageModel get bestPageModel;
}

/// Scope для оформления заказов
class BestPageScope implements IBestPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final BestPageClient _bestPageClient;

  late final BestPageModel _bestPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  BestPageModel get bestPageModel => _bestPageModel;

  /// Конструткор [BestPageScope]
  BestPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _bestPageClient = BestPageClient(_dio);

    _initBestPageModel();
  }

  void _initBestPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockBestPageRepository()
        : BestPageRepository(_bestPageClient);
    _bestPageModel = BestPageModel(repository, errorHandler);
  }
}
