import 'package:soft_weather_tennis/features/pages/profile_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/information.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/mappers/achievement_mapper.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/mappers/set_mapper.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/mappers/statistics_mapper.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/achievement_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/game_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/statistics_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/training_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/user_data_dto.dart';

/// Репозиторий для профиля
class ProfilePageRepository {
  final ProfilePageClient _profilePageClient;

  /// Конструктор [ProfilePageRepository]
  ProfilePageRepository(this._profilePageClient);

  /// Возвращает данные пользователя
  Future<UserInfo?> getUserInfo() => _profilePageClient.getUserInfo().then(
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

  /// Возвращает данные страницы информация
  Future<Information?> getInformationData() =>
      _profilePageClient.getInformationData().then(
        (dto) {
          final data = UserDataDtO.fromJson(dto.data as Map<String, dynamic>);
          final res = Information(
            trophiesAllCount: data.indicators?.trophy?.total ?? 0,
            charactersInfo: CharactersInfo(
              age: data.user?.characteristics?.age ?? 0,
              height: data.user?.characteristics?.height ?? 0,
              ageInTennis: data.user?.characteristics?.tennisYear ?? 0,
              forehand: data.user?.characteristics?.forehand ?? '',
              backhand: data.user?.characteristics?.backhand ?? '',
              technicality: data.user?.characteristics?.technicality ?? 0,
              trainer: data.user?.characteristics?.trainer ?? '',
            ),
            efficiency: data.indicators?.efficiency ?? 0,
            gameCount: data.indicators?.games ?? 0,
            lastTrophies: [],
            trophiesCount: data.indicators?.trophy?.total ?? 0,
            ratingPosition: data.rating?.place ?? 0,
            ratingChanges:
                (data.rating?.place ?? 0) - (data.rating?.prevPlace ?? 0),
          );

          return res;
        },
      );

  /// Возвращает данные страницы игра
  Future<GameDataLevels?> getGameData() =>
      _profilePageClient.getGameData().then(
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

  /// Возвращает данные страницы статистика
  Future<StatisticsList?> getStatisticsData(Map<String, dynamic> body) =>
      _profilePageClient.getStatisticsData(body).then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <Statistics>[];
          num? averageEfficiency = 0;
          var date = '';
          for (final element in data) {
            date = StatisticsDataDtO.fromJson(element as Map<String, dynamic>)
                    .completedAt ??
                '';
            averageEfficiency = (averageEfficiency ?? 0) +
                (StatisticsDataDtO.fromJson(element).efficiency ?? 0);
            items.add(statisticsDataMapper(
              StatisticsDataDtO.fromJson(element),
            ));
          }
          averageEfficiency = (averageEfficiency ?? 0) / items.length;
          return StatisticsList(
            date: date,
            averageEfficiency: '$averageEfficiency',
            efficiencyList: items,
          );
        },
      );

  /// Возвращает данные страницы тренировка
  Future<TrainingInfo?> getTrainingData(String id) =>
      _profilePageClient.getTrainingData('/api/game/$id').then(
        (dto) {
          final data =
              TrainingDataDtO.fromJson(dto.data as Map<String, dynamic>);

          return TrainingInfo(
            date: '${data.completedAt?.substring(8, 10)}.'
                '${data.completedAt?.substring(5, 7)}.'
                '${data.completedAt?.substring(0, 4)}',
            complexity: '${data.complexity}',
            level: data.level ?? 0,
            percent: data.efficiency ?? 0,
            sets: setDataMapper(data),
          );
        },
      );

  /// Возвращает список достижений
  Future<List<Achievement>?> getAchievementsData() =>
      _profilePageClient.getAchievementsData().then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <Achievement>[];
          for (final element in data) {
            items.add(achievementDataMapper(
              AchievementDataDtO.fromJson(element as Map<String, dynamic>),
            ));
          }
          return items;
        },
      );
}
