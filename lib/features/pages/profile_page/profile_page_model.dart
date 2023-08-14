import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/information.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/repository/profile_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for ProfilePage module
class ProfilePageModel extends ElementaryModel {
  final ProfilePageRepository _profilePageRepository;

  /// Конструктор [ProfilePageModel]
  ProfilePageModel(
    this._profilePageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных пользователя
  Future<UserInfo> getUserInfo() async {
    late final UserInfo res;
    await ExceptionHandler.shellException(() async {
      res = (await _profilePageRepository.getUserInfo())!;
      return res;
    });
    return res;
  }

  /// Получение данных вкладки "информация"
  Future<Information> getInformationData() async {
    late final Information res;
    await ExceptionHandler.shellException(() async {
      res = (await _profilePageRepository.getInformationData())!;
      return res;
    });
    return res;
  }

  /// Получение данных вкладки "игра"
  Future<GameDataLevels> getGameData() async {
    late final GameDataLevels res;
    await ExceptionHandler.shellException(() async {
      res = (await _profilePageRepository.getGameData())!;
      return res;
    });
    return res;
  }

  /// Получение данных вкладки "статистика"
  Future<StatisticsList> getStatisticsData({String? date}) async {
    late final StatisticsList res;
    final body = <String, dynamic>{
      'limit': 8,
      'page': 1,
      'date': date,
    };
    await ExceptionHandler.shellException(() async {
      res = (await _profilePageRepository.getStatisticsData(body))!;
      return res;
    });
    return res;
  }

  /// Получение данных вкладки "тренировка"
  Future<TrainingInfo> getTrainingData(String id) async {
    late final TrainingInfo res;

    await ExceptionHandler.shellException(() async {
      res = (await _profilePageRepository.getTrainingData(id))!;
      return res;
    });
    return res;
  }

  /// Получение данных страницы "достижения"
  Future<List<Achievement>> getAchievementsData() async {
    late final List<Achievement> res;
    await ExceptionHandler.shellException(() async {
      res = (await _profilePageRepository.getAchievementsData())!;
      return res;
    });
    return res;
  }
}
