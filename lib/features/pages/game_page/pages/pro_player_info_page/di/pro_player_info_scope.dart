import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/game_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/mock/mock_game_screen_repositoy.dart';

/// Интерфейс Scope для ProPlayerInfo
abstract class IProPlayerInfoPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы ProPlayerInfo
  ProPlayerInfoPageModel get proPlayerInfoPageModel;
}

/// Scope для оформления заказов
class ProPlayerInfoPageScope implements IProPlayerInfoPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final GamePageClient _gamePageClient;

  late final ProPlayerInfoPageModel _proPlayerInfoPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  ProPlayerInfoPageModel get proPlayerInfoPageModel => _proPlayerInfoPageModel;

  /// Конструткор [ProPlayerInfoPageScope]
  ProPlayerInfoPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _gamePageClient = GamePageClient(_dio);

    _initProPlayerInfoPageModel();
  }

  void _initProPlayerInfoPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockGamePageRepository()
        : GamePageRepository(_gamePageClient);
    _proPlayerInfoPageModel = ProPlayerInfoPageModel(repository, errorHandler);
  }
}
