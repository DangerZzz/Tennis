import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for GamePage module
class GamePageModel extends ElementaryModel {
  final GamePageRepository _gamePageRepository;

  /// Конструктор [GamePageModel]
  GamePageModel(
    this._gamePageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных страницы
  Future<List<Statistics>> getTrainingsData() async {
    final body = <String, dynamic>{
      'limit': 4,
      'page': 1,
    };
    var res = <Statistics>[];
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getTrainingsData(body))!;
      return res;
    });
    return res;
  }

  /// Получение полного списка про игроков
  Future<List<ProPlayer>> getProPlayerData({
    required num limit,
    required num page,
  }) async {
    final body = <String, dynamic>{
      'limit': limit,
      'page': page,
    };
    var res = <ProPlayer>[];
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getProPlayerData(body))!;
    });
    return res;
  }

  ///данные о сложности/уровне
  Future<GameDataLevels> getGameData() async {
    late final GameDataLevels res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getGameData())!;
      return res;
    });
    return res;
  }

  /// Получение полного списка про игроков для поиска
  Future<List<ProPlayer>> getProPlayerSearchData() async {
    late final List<ProPlayer> res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getProPlayerSearchData())!;
      return res;
    });
    return res;
  }

  /// Получение данных вкладки "статистика"
  Future<StatisticsList> getStatisticsData() async {
    late final StatisticsList res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getStatisticsData())!;
      return res;
    });
    return res;
  }
}
