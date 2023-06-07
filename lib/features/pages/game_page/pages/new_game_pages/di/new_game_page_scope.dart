import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/game_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/mock/mock_game_screen_repositoy.dart';

/// Интерфейс Scope для экранов фичи Game
abstract class INewGamePageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Game
  NewGamePageModel get newGamePageModel;
}

/// Scope для оформления заказов
class NewGamePageScope implements INewGamePageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final GamePageClient _gamePageClient;

  late final NewGamePageModel _newGamePageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  NewGamePageModel get newGamePageModel => _newGamePageModel;

  /// Конструткор [NewGamePageScope]
  NewGamePageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _gamePageClient = GamePageClient(_dio);

    _initNewGamePageModel();
  }

  void _initNewGamePageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockGamePageRepository()
        : GamePageRepository(_gamePageClient);
    _newGamePageModel = NewGamePageModel(repository, errorHandler);
  }
}
