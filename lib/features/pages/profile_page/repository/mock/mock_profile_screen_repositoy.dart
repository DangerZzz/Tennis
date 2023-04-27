import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/information.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/level_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/repository/profile_screen_repository.dart';

/// mock repository
class MockProfilePageRepository implements ProfilePageRepository {
  ///
  @override
  Future<UserInfo> getUserInfo() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return UserInfo(
      name: 'Дмитрий',
      avatarUrl: 'https://picsum.photos/200',
      backgroundImageUrl:
          'lib/features/pages/profile_page/assets/images/profile_background.png',
      points: '50 000',
      rank: 'Король SMASH',
      surname: 'Колесников',
      currentLevel: 4,
      nextLevel: 5,
    );
  }

  ///
  @override
  Future<Information> getInformationData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return Information(
      gameCount: 30,
      efficiency: 85,
      trophiesCount: 11,
      trophiesAllCount: 42,
      lastTrophies: [
        Achievement(
          name: 'Трофей 1',
          url:
              'lib/features/pages/profile_page/assets/images/achivment_test.png',
          isGetting: false,
          date: 'date',
        ),
        Achievement(
          name: 'Работа ногами',
          url:
              'lib/features/pages/profile_page/assets/images/achivment_test.png',
          isGetting: false,
          date: 'date',
        ),
        Achievement(
          name: 'Трофей очень длинный супер капец просто 3',
          url:
              'lib/features/pages/profile_page/assets/images/achivment_test.png',
          isGetting: false,
          date: 'date',
        ),
      ],
      charactersInfo: CharactersInfo(
        height: '',
        age: '',
        ageInTennis: '',
        backhand: '',
        forehand: '',
        technicality: '',
        trainer: '',
      ),
      ratingPosition: 14,
      ratingChanges: 0,
    );
  }

  ///
  @override
  Future<GameData> getGameData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return GameData(
      currentLevel: 3,
      levels: [
        LevelData(
          complexity: 'Master',
          isAvailability: true,
          level: 1,
        ),
        LevelData(
          complexity: 'Medium',
          isAvailability: true,
          level: 2,
        ),
        LevelData(
          complexity: 'Light',
          isAvailability: true,
          level: 3,
        ),
        LevelData(
          complexity: 'Medium',
          isAvailability: true,
          level: 4,
        ),
        LevelData(
          complexity: 'Master',
          isAvailability: true,
          level: 5,
        ),
        LevelData(
          complexity: 'Medium',
          isAvailability: false,
          level: 6,
        ),
        LevelData(
          complexity: 'Medium',
          isAvailability: false,
          level: 7,
        ),
        LevelData(
          complexity: 'Medium',
          isAvailability: false,
          level: 8,
        ),
        LevelData(
          complexity: 'Medium',
          isAvailability: false,
          level: 9,
        ),
        LevelData(
          complexity: 'Medium',
          isAvailability: false,
          level: 10,
        ),
      ],
    );
  }

  ///
  @override
  Future<StatisticsList> getStatisticsData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return StatisticsList(
      averageEfficiency: '48',
      efficiencyList: [
        Statistics(
          date: 1681171200,
          efficiency: 55,
        ),
        Statistics(
          date: 1681257600,
          efficiency: 25,
        ),
        Statistics(
          date: 1681344000,
          efficiency: 12,
        ),
        Statistics(
          date: 1681430400,
          efficiency: 100,
        ),
        Statistics(
          date: 1681516800,
          efficiency: 65,
        ),
        Statistics(
          date: 1681689599,
          efficiency: 45,
        ),
        Statistics(
          date: 1681775999,
          efficiency: 90,
        ),
        Statistics(
          date: 1681776000,
          efficiency: 94,
        ),
      ],
    );
  }

  ///
  @override
  Future<TrainingInfo> getTrainingData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return TrainingInfo(
      level: 4,
      complexity: 'Light',
      percent: 80,
      sets: [
        Sets(
          game: [
            Game(
              percent: 80,
              gameNumber: 1,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 2,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 3,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 4,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
          ],
        ),
        Sets(
          game: [
            Game(
              percent: 80,
              gameNumber: 1,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 2,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
          ],
        ),
        Sets(
          game: [
            Game(
              percent: 80,
              gameNumber: 1,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
          ],
        ),
        Sets(
          game: [
            Game(
              percent: 80,
              gameNumber: 1,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 2,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
          ],
        ),
        Sets(
          game: [
            Game(
              percent: 80,
              gameNumber: 1,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 2,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 3,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 4,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 5,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 6,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Out'),
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              gameNumber: 7,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  ///
  @override
  Future<List<Achievement>> getAchievementsData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return [
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: '1Smash power',
        url: 'lib/features/pages/profile_page/assets/images/achivment_test.png',
        isGetting: true,
        date: '20.12.2023',
      ),
      Achievement(
        name: 'Smash power',
        url: 'lib/features/pages/profile_page/assets/images/achivment_test.png',
        isGetting: true,
        date: '20.12.2023',
      ),
      Achievement(
        name: 'Smash power',
        url: 'lib/features/pages/profile_page/assets/images/achivment_test.png',
        isGetting: true,
        date: '20.12.2023',
      ),
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: 'Smash power',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
      Achievement(
        name: 'Заряженный',
        url:
            'lib/features/pages/profile_page/assets/images/achievement_grey.png',
        isGetting: false,
        date: '',
      ),
    ];
  }
}
