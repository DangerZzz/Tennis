import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/repository/mock/mock_settings_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/repository/trainer_page_repository.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/trainer_page_model.dart';

/// Интерфейс Scope для экранов фичи Settings
abstract class ITrainerPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы TrainerPage
  TrainerPageModel get trainerPageModel;
}

/// Scope
class TrainerPageScope implements ITrainerPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final TrainerPageClient _trainerPageClient;

  late final TrainerPageModel _trainerPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  TrainerPageModel get trainerPageModel => _trainerPageModel;

  /// Конструткор [TrainerPageScope]
  TrainerPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _trainerPageClient = TrainerPageClient(_dio);

    _initTrainerPageModel();
  }

  void _initTrainerPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockTrainerPageRepository()
        : TrainerPageRepository(_trainerPageClient);
    _trainerPageModel = TrainerPageModel(repository, errorHandler);
  }
}
