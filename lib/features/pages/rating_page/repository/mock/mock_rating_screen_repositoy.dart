import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/search_rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/repository/rating_screen_repository.dart';

/// mock repository
class MockRatingPageRepository implements RatingPageRepository {
  ///
  @override
  Future<RatingList> getRatingList(Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return RatingList(
      ratingData: [
        Rating(
          avatarUrl: 'https://picsum.photos/200',
          name: 'Никита Волков',
          points: '11.000',
          isUser: false,
          position: 1,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/300',
          name: 'Егор Ж.',
          points: '7.000',
          isUser: false,
          position: 2,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/400',
          name: 'Кайрат А.',
          points: '6.000',
          isUser: false,
          position: 3,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/500',
          name: 'Артём Каер',
          points: '5.000',
          isUser: true,
          position: 4,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/600',
          name: 'Данил Еремин',
          points: '4.000',
          isUser: false,
          position: 5,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/700',
          name: 'Максим Овечкин',
          points: '3.000',
          isUser: false,
          position: 6,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/800',
          name: 'Данил Антонов',
          points: '2.000',
          isUser: false,
          position: 7,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/200',
          name: 'Александр Друздь',
          points: '1.000',
          isUser: false,
          position: 8,
        ),
      ],
    );
  }

  @override
  Future<SearchRatingList> getSearchRatingList(
      Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return SearchRatingList(
      ratingData: [
        Rating(
          avatarUrl: 'https://picsum.photos/200',
          name: 'Никита Волков',
          points: '11.000',
          isUser: false,
          position: 1,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/300',
          name: 'Егор Ж.',
          points: '7.000',
          isUser: false,
          position: 2,
        ),
      ],
      probablyRatingData: [
        Rating(
          avatarUrl: 'https://picsum.photos/400',
          name: 'Кайрат А.',
          points: '6.000',
          isUser: false,
          position: 3,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/500',
          name: 'Артём Каер',
          points: '5.000',
          isUser: true,
          position: 4,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/600',
          name: 'Данил Еремин',
          points: '4.000',
          isUser: false,
          position: 5,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/700',
          name: 'Максим Овечкин',
          points: '3.000',
          isUser: false,
          position: 6,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/800',
          name: 'Данил Антонов',
          points: '2.000',
          isUser: false,
          position: 7,
        ),
        Rating(
          avatarUrl: 'https://picsum.photos/200',
          name: 'Александр Друздь',
          points: '1.000',
          isUser: false,
          position: 8,
        ),
      ],
    );
  }
}
