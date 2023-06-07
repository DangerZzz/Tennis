import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/game_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/statistics_in_game_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/mock/mock_game_screen_repositoy.dart';

/// Интерфейс Scope для StatisticsInGame
abstract class IStatisticsInGameScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы ProPlayerInfo
  StatisticsInGameModel get statisticsInGameModel;
}

/// Scope для оформления заказов
class StatisticsInGameScope implements IStatisticsInGameScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final GamePageClient _gamePageClient;

  late final StatisticsInGameModel _statisticsInGameModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  StatisticsInGameModel get statisticsInGameModel => _statisticsInGameModel;

  /// Конструткор [StatisticsInGameScope]
  StatisticsInGameScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _gamePageClient = GamePageClient(_dio);

    _initStatisticsInGameModel();
  }

  void _initStatisticsInGameModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockGamePageRepository()
        : GamePageRepository(_gamePageClient);
    _statisticsInGameModel = StatisticsInGameModel(repository, errorHandler);
  }
}
