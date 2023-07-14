import 'package:soft_weather_tennis/features/pages/profile_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/information.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/user_data_dto.dart';

/// Репозиторий для главной
class ProfilePageRepository {
  final ProfilePageClient _ProfilePageClient;

  /// Конструктор [ProfilePageRepository]
  ProfilePageRepository(this._ProfilePageClient);

  /// Возвращает данные пользователя
  Future<UserInfo?> getUserInfo() => _ProfilePageClient.getUserInfo().then(
        (dto) {
          final data = UserDataDtO.fromJson(dto.data as Map<String, dynamic>);
          final res = UserInfo(
            name: data.user?.name ?? '', //.split('')[0] ?? '',
            avatarUrl: data.user?.avatar?.src ?? '',
            surname: data.user?.name?.split('')[0] ?? '',
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
      _ProfilePageClient.getInformationData().then(
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
  Future<GameData?> getGameData() => _ProfilePageClient.getGameData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные страницы статистика
  Future<StatisticsList?> getStatisticsData() =>
      _ProfilePageClient.getStatisticsData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные страницы тренировка
  Future<TrainingInfo?> getTrainingData() =>
      _ProfilePageClient.getTrainingData().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает список достижений
  Future<List<Achievement>?> getAchievementsData() =>
      _ProfilePageClient.getAchievementsData().then(
        (dto) {
          return null;
        },
      );
}
