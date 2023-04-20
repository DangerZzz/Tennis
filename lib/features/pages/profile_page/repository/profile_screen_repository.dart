import 'package:soft_weather_tennis/features/pages/profile_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/information.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';

/// Репозиторий для главной
class ProfilePageRepository {
  final ProfilePageClient _ProfilePageClient;

  /// Конструктор [ProfilePageRepository]
  ProfilePageRepository(this._ProfilePageClient);

  /// Возвращает данные пользователя
  Future<UserInfo?> getUserInfo() => _ProfilePageClient.getUserInfo().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные страницы информация
  Future<Information?> getInformationData() =>
      _ProfilePageClient.getInformationData().then(
        (dto) {
          return null;
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
