import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/trainer_game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/repository/mock/mock_settings_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/repository/trainer_page_repository.dart';

/// Интерфейс Scope для экранов фичи Game
abstract class ITrainerGamePageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Game
  TrainerGamePageModel get trainerGamePageModel;
}

/// Scope для оформления заказов
class TrainerGamePageScope implements ITrainerGamePageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final TrainerPageClient _trainerPageClient;

  late final TrainerGamePageModel _trainerGamePageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  TrainerGamePageModel get trainerGamePageModel => _trainerGamePageModel;

  /// Конструткор [TrainerGamePageScope]
  TrainerGamePageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _trainerPageClient = TrainerPageClient(_dio);

    _initTrainerGamePageModel();
  }

  void _initTrainerGamePageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockTrainerPageRepository()
        : TrainerPageRepository(_trainerPageClient);
    _trainerGamePageModel = TrainerGamePageModel(repository, errorHandler);
  }
}
