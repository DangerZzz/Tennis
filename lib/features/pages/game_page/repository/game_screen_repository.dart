import 'package:soft_weather_tennis/features/pages/game_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/preparing_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_player_info.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_players_mapper.dart';
import 'package:soft_weather_tennis/features/pages/game_page/dto/preparing_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/game_page/dto/pro_players_dto.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/mappers/statistics_mapper.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/game_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/statistics_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/user_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/domain/current_game_data.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/domain/game_mapper.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/dto/game_data_dto.dart';

/// Репозиторий для главной
class GamePageRepository {
  final GamePageClient _gamePageClient;

  /// Конструктор [GamePageRepository]
  GamePageRepository(this._gamePageClient);

  /// Возвращает данные страницы "игра"
  Future<List<Statistics>?> getTrainingsData(Map<String, dynamic> body) =>
      _gamePageClient.getTrainingsData(body).then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <Statistics>[];
          for (final element in data) {
            items.add(statisticsDataMapper(
              StatisticsDataDtO.fromJson(element as Map<String, dynamic>),
            ));
          }
          return items;
        },
      );

  /// Возвращает данные ProPlayer
  Future<List<ProPlayer>?> getProPlayerData(Map<String, dynamic> body) =>
      _gamePageClient.getProPlayerData(body).then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <ProPlayer>[];
          for (final element in data) {
            items.add(proPlayersDataMapper(
              ProPlayersDtO.fromJson(element as Map<String, dynamic>),
            ));
          }
          return items;
        },
      );

  /// Возвращает данные страницы игра
  Future<GameDataLevels?> getGameData() => _gamePageClient.getGameData().then(
        (dto) {
          final data = GameDataDtO.fromJson(dto.data as Map<String, dynamic>);

          final res = GameDataLevels(
            maxLevel: ((data.maxLevel ?? 0) > 10)
                ? 10
                : ((data.maxLevel ?? 0) < 1)
                    ? 1
                    : (data.maxLevel ?? 1),
            maxComplexity: data.maxComplexity ?? 'LIGHT',
          );

          return res;
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

  /// Возвращает данные подготовки к тренировке
  Future<PreparingData?> getPreparingData(Map<String, dynamic> body) =>
      _gamePageClient.getPreparingData(body).then(
        (dto) {
          final data =
              PreparingDataDtO.fromJson(dto.data as Map<String, dynamic>);

          final min = ((data.time ?? 0) / 60 % 60).toInt();
          final sec = ((data.time ?? 0) / 1 % 60).toInt();
          var time = '$min:$sec';
          if ('$sec'.length == 1) {
            time = '$min:${sec}0';
          }
          return PreparingData(
            time: time,
            games: data.games ?? 0,
            sets: data.sets ?? 0,
            hits: data.hits ?? [],
          );
        },
      );

  /// Возвращает данные инициализации игры
  Future<String?> getInitialData(Map<String, dynamic> body) =>
      _gamePageClient.getInitialData(body).then(
        (dto) {
          final res = dto.data as Map<String, dynamic>;

          return res['_id'] as String;
        },
      );

  /// Возвращает данные инициализации игры
  Future<String?> getQRData(Map<String, dynamic> body) =>
      _gamePageClient.getQRData(body).then(
        (dto) {
          final res = dto.data as Map<String, dynamic>;

          return res['connectToken'] as String;
        },
      );

  /// Возвращает данные инициализации игры
  Future<String?> postConnect(Map<String, dynamic> body) =>
      _gamePageClient.postConnect(body).then(
        (dto) {
          return '';
          // final res = dto.data as Map<String, dynamic>;
          //
          // return res['connectToken'] as String;
        },
      );

  /// Возвращает данные инициализации игры
  Future<CurrentGameData?> gameStart(String tokens) =>
      _gamePageClient.gameStart(tokens).then(
        (dto) {
          final res =
              GameStartDataDtO.fromJson(dto.data as Map<String, dynamic>);
          final dataRes = gameDataMapper(res);
          return dataRes;
        },
      );

  /// Возвращает данные пользователя
  Future<UserInfo?> getUserInfo() => _gamePageClient.getUserInfo().then(
        (dto) {
          final data = UserDataDtO.fromJson(dto.data as Map<String, dynamic>);
          final res = UserInfo(
            name: data.user?.name?.split(' ')[1] ?? '',
            avatarUrl: data.user?.avatar?.src ?? '',
            surname: data.user?.name?.split(' ')[0] ?? '',
            backgroundImageUrl: data.user?.wallpaper?.src ?? '',
            currentLevel: data.rating?.prevPlace ?? 0,
            nextLevel: data.rating?.place ?? 0,
            points: data.rating?.score ?? 0,
            rank: '',
          );

          return res;
        },
      );
}
