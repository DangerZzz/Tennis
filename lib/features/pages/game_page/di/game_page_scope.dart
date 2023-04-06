import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/game_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/mock/mock_game_screen_repositoy.dart';

/// Интерфейс Scope для экранов фичи Game
abstract class IGamePageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Game
  GamePageModel get gamePageModel;
}

/// Scope для оформления заказов
class GamePageScope implements IGamePageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final GamePageClient _gamePageClient;

  late final GamePageModel _gamePageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  GamePageModel get gamePageModel => _gamePageModel;

  /// Конструткор [GamePageScope]
  GamePageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _gamePageClient = GamePageClient(_dio);

    _initGamePageModel();
  }

  void _initGamePageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockGamePageRepository()
        : GamePageRepository(_gamePageClient);
    _gamePageModel = GamePageModel(repository, errorHandler);
  }
}
