import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for StatisticsInGame module
class StatisticsInGameModel extends ElementaryModel {
  final GamePageRepository _gamePageRepository;

  /// Конструктор [StatisticsInGameModel]
  StatisticsInGameModel(
    this._gamePageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных вкладки "статистика"
  Future<StatisticsList> getStatisticsData() async {
    late final StatisticsList res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getStatisticsData())!;
      return res;
    });
    return res;
  }

  /// Получение данных вкладки "тренировка"
  Future<TrainingInfo> getTrainingData() async {
    late final TrainingInfo res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getTrainingData())!;
      return res;
    });
    return res;
  }
}
