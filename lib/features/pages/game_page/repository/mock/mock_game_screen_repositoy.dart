import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/preparing_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_player_info.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';

/// mock repository
class MockGamePageRepository implements GamePageRepository {
  @override
  Future<List<Statistics>> getTrainingsData(Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return [
      // Training(
      //   id: 1,
      //   name: 'Стандартная',
      //   efficiency: '79%',
      // ),
      // Training(
      //   id: 1,
      //   name: 'Карлос А.',
      //   efficiency: '49%',
      // ),
      // Training(
      //   id: 1,
      //   name: 'Карлос А.',
      //   efficiency: '100%',
      // ),
      // Training(
      //   id: 1,
      //   name: 'Стандартная',
      //   efficiency: '9%',
      // ),
    ];
  }

  @override
  Future<List<ProPlayer>> getProPlayerData(Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return <ProPlayer>[
      // ProPlayer(
      //   id: 1,
      //   rating: 5,
      //   name: 'Карлос Алькарас',
      //   description: 'Действующая 1-я ракетка',
      //   imageUrl: 'https://picsum.photos/300',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 4,
      //   name: 'Рафаэль Надаль',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/400',
      // ),
      // ProPlayer(
      //   id: 1,
      //   rating: 5,
      //   name: 'Карлос Алькарас',
      //   description: 'Действующая 1-я ракетка',
      //   imageUrl: 'https://picsum.photos/300',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 4,
      //   name: 'Рафаэль Надаль',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/400',
      // ),
      // ProPlayer(
      //   id: 1,
      //   rating: 5,
      //   name: 'Карлос Алькарас',
      //   description: 'Действующая 1-я ракетка',
      //   imageUrl: 'https://picsum.photos/300',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 4,
      //   name: 'Рафаэль Надаль',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/400',
      // ),
      // ProPlayer(
      //   id: 1,
      //   rating: 5,
      //   name: 'Карлос Алькарас',
      //   description: 'Действующая 1-я ракетка',
      //   imageUrl: 'https://picsum.photos/300',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 4,
      //   name: 'Рафаэль Надаль',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/400',
      // ),
      // ProPlayer(
      //   id: 1,
      //   rating: 5,
      //   name: 'Карлос Алькарас',
      //   description: 'Действующая 1-я ракетка',
      //   imageUrl: 'https://picsum.photos/300',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 4,
      //   name: 'Рафаэль Надаль',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/400',
      // ),
      // ProPlayer(
      //   id: 1,
      //   rating: 5,
      //   name: 'Карлос Алькарас',
      //   description: 'Действующая 1-я ракетка',
      //   imageUrl: 'https://picsum.photos/300',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 4,
      //   name: 'Рафаэль Надаль',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/400',
      // ),
    ];
  }

  @override
  Future<List<ProPlayer>> getProPlayerSearchData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return <ProPlayer>[
      // ProPlayer(
      //   id: 1,
      //   rating: 5,
      //   name: 'Карлос Алькарас',
      //   description: 'Действующая 1-я ракетка',
      //   imageUrl: 'https://picsum.photos/300',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 4,
      //   name: 'Рафаэль Надаль',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/400',
      // ),
      // ProPlayer(
      //   id: 2,
      //   rating: 3,
      //   name: 'Аркадий Для Поиска',
      //   description: 'Чемпион мира',
      //   imageUrl: 'https://picsum.photos/500',
      // ),
    ];
  }

  @override
  Future<ProPlayerInfoData> getProPlayerInfoData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return ProPlayerInfoData(
      name: 'Карлос Алькарас',
      imageUrl: 'https://picsum.photos/500',
      description:
          'Карлос Алькарас Гарфия — испанский профессиональный теннисист; действующая первая ракетка мира, самый молодой лидер мирового рейтинга в истории среди мужчин; победитель одного турнира Большого шлема в одиночном разряде; победитель шести турниров ATP в одиночном разряде.',
      rating1: 5,
      rating2: 1,
      rating3: 2,
      rating4: 4,
    );
  }

  @override
  Future<StatisticsList> getStatisticsData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return StatisticsList(
      averageEfficiency: '48',
      efficiencyList: [],
      date: '',
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              hits: Hits(worked: 1, out: 1, grid: 1),
              gameNumber: 3,
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
            Game(
              percent: 80,
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
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
              hits: Hits(worked: 1, out: 1, grid: 1),
              practicedBeats: [
                PracticedBeats(name: 'Forehand', state: 'Ok'),
              ],
            ),
          ],
        ),
      ],
      date: '',
    );
  }

  @override
  Future<GameDataLevels?> getGameData() async {
    return null;
  }

  @override
  Future<String?> getInitialData(Map<String, dynamic> body) async {
    return null;
  }

  @override
  Future<PreparingData?> getPreparingData(Map<String, dynamic> body) async {
    return null;
  }

  @override
  Future<String?> getQRData(Map<String, dynamic> body) async {
    return null;
  }

  @override
  Future<String?> postConnect(Map<String, dynamic> body) async {
    return null;
  }

  @override
  Future<String> gameStart(String body) async {
    return '';
  }

  @override
  Future<UserInfo?> getUserInfo() async {
    return null;
  }
}
