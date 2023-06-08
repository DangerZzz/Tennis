import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_player_info.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';

/// mock repository
class MockGamePageRepository implements GamePageRepository {
  @override
  Future<GameData> getGameData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return GameData(
      fastAdvice:
          'Оставаться в форме тебе помогут\nпакровские батончики с высоким\n'
          'содержанием чего-нибудь.',
      fastAdviceImageUrl: 'https://picsum.photos/200',
      proPlayers: [
        ProPlayer(
          id: 1,
          rating: 5,
          name: 'Карлос Алькарас',
          description: 'Действующая 1-я ракетка',
          imageUrl: 'https://picsum.photos/300',
        ),
        ProPlayer(
          id: 2,
          rating: 4,
          name: 'Рафаэль Надаль',
          description: 'Чемпион мира',
          imageUrl: 'https://picsum.photos/400',
        ),
      ],
      trainings: [
        Training(
          id: 1,
          name: 'Стандартная',
          efficiency: '79%',
        ),
        Training(
          id: 1,
          name: 'Карлос А.',
          efficiency: '49%',
        ),
        Training(
          id: 1,
          name: 'Карлос А.',
          efficiency: '100%',
        ),
        Training(
          id: 1,
          name: 'Стандартная',
          efficiency: '9%',
        ),
      ],
    );
  }

  @override
  Future<List<ProPlayer>> getProPlayerData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return <ProPlayer>[
      ProPlayer(
        id: 1,
        rating: 5,
        name: 'Карлос Алькарас',
        description: 'Действующая 1-я ракетка',
        imageUrl: 'https://picsum.photos/300',
      ),
      ProPlayer(
        id: 2,
        rating: 4,
        name: 'Рафаэль Надаль',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/400',
      ),
      ProPlayer(
        id: 1,
        rating: 5,
        name: 'Карлос Алькарас',
        description: 'Действующая 1-я ракетка',
        imageUrl: 'https://picsum.photos/300',
      ),
      ProPlayer(
        id: 2,
        rating: 4,
        name: 'Рафаэль Надаль',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/400',
      ),
      ProPlayer(
        id: 1,
        rating: 5,
        name: 'Карлос Алькарас',
        description: 'Действующая 1-я ракетка',
        imageUrl: 'https://picsum.photos/300',
      ),
      ProPlayer(
        id: 2,
        rating: 4,
        name: 'Рафаэль Надаль',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/400',
      ),
      ProPlayer(
        id: 1,
        rating: 5,
        name: 'Карлос Алькарас',
        description: 'Действующая 1-я ракетка',
        imageUrl: 'https://picsum.photos/300',
      ),
      ProPlayer(
        id: 2,
        rating: 4,
        name: 'Рафаэль Надаль',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/400',
      ),
      ProPlayer(
        id: 1,
        rating: 5,
        name: 'Карлос Алькарас',
        description: 'Действующая 1-я ракетка',
        imageUrl: 'https://picsum.photos/300',
      ),
      ProPlayer(
        id: 2,
        rating: 4,
        name: 'Рафаэль Надаль',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/400',
      ),
      ProPlayer(
        id: 1,
        rating: 5,
        name: 'Карлос Алькарас',
        description: 'Действующая 1-я ракетка',
        imageUrl: 'https://picsum.photos/300',
      ),
      ProPlayer(
        id: 2,
        rating: 4,
        name: 'Рафаэль Надаль',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/400',
      ),
    ];
  }

  @override
  Future<List<ProPlayer>> getProPlayerSearchData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return <ProPlayer>[
      ProPlayer(
        id: 1,
        rating: 5,
        name: 'Карлос Алькарас',
        description: 'Действующая 1-я ракетка',
        imageUrl: 'https://picsum.photos/300',
      ),
      ProPlayer(
        id: 2,
        rating: 4,
        name: 'Рафаэль Надаль',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/400',
      ),
      ProPlayer(
        id: 2,
        rating: 3,
        name: 'Аркадий Для Поиска',
        description: 'Чемпион мира',
        imageUrl: 'https://picsum.photos/500',
      ),
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
      efficiencyList: [
        Statistics(
          date: 1681171200,
          efficiency: 55,
          type: 'Стандартная',
        ),
        Statistics(
          date: 1681257600,
          efficiency: 25,
          type: 'Стандартная',
        ),
        Statistics(
          date: 1681344000,
          efficiency: 12,
          type: 'Стандартная',
        ),
        Statistics(
          date: 1681430400,
          efficiency: 100,
          type: 'Стандартная',
        ),
        Statistics(
          date: 1681516800,
          efficiency: 65,
          type: 'Стандартная',
        ),
        Statistics(
          date: 1681689599,
          efficiency: 45,
          type: 'Стандартная',
        ),
        Statistics(
          date: 1681775999,
          efficiency: 90,
          type: 'Стандартная',
        ),
        Statistics(
          date: 1681776000,
          efficiency: 94,
          type: 'Стандартная',
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
}
