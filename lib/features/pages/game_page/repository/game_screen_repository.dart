import 'package:soft_weather_tennis/features/pages/game_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_player_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';

/// Репозиторий для главной
class GamePageRepository {
  final GamePageClient _gamePageClient;

  /// Конструктор [GamePageRepository]
  GamePageRepository(this._gamePageClient);

  /// Возвращает данные страницы "игра"
  Future<GameData?> getGameData() => _gamePageClient.getGameData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные ProPlayer
  Future<List<ProPlayer>?> getProPlayerData() =>
      _gamePageClient.getProPlayerData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные поиска ProPlayer
  Future<List<ProPlayer>?> getProPlayerSearchData() =>
      _gamePageClient.getProPlayerSearchData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные поиска ProPlayer
  Future<ProPlayerInfoData?> getProPlayerInfoData() =>
      _gamePageClient.getProPlayerInfoData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные поиска ProPlayer
  Future<StatisticsList?> getStatisticsData() =>
      _gamePageClient.getStatisticsData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные поиска ProPlayer
  Future<TrainingInfo?> getTrainingData() =>
      _gamePageClient.getTrainingData().then(
        (dto) {
          return null;
        },
      );
}
