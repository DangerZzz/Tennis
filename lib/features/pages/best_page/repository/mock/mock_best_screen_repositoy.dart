import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list.dart';
import 'package:soft_weather_tennis/features/pages/best_page/repository/best_screen_repository.dart';

/// mock repository
class MockBestPageRepository implements BestPageRepository {
  ///
  @override
  Future<BestDataList?> getBestListData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return BestDataList(
      bestData: [
        BestData(
          imageUrl: 'https://picsum.photos/500/400',
          age: '12 лет',
          name: 'Андрей Артёмов',
          rank: 'Король SMASH',
          description:
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
          topCount: 12,
        ),
        BestData(
          imageUrl: 'https://picsum.photos/500/600',
          age: '18 лет',
          name: 'Другой Андрей Артёмов',
          rank: 'Король SMASH',
          description:
              'Андрей Артёмов сегодня молодец! Он сделал что-то такое крутое что мы написали аж 3 предложения!!!!',
          topCount: 1,
        ),
        BestData(
          imageUrl: 'https://picsum.photos/500/400',
          age: '12 лет',
          name: 'Андрей Артёмов с ну очень длинным именем',
          rank: 'Король SMASH',
          description: 'description',
          topCount: 12,
        ),
        BestData(
          imageUrl: 'https://picsum.photos/500/400',
          age: '12 лет',
          name: 'Андрей Артёмов',
          rank: 'Король SMASH',
          description: 'description',
          topCount: 12,
        ),
      ],
    );
  }
}
