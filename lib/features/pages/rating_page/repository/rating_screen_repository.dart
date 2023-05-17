import 'package:soft_weather_tennis/features/pages/rating_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/search_rating_list.dart';

/// Репозиторий для главной
class RatingPageRepository {
  final RatingPageClient _ratingPageClient;

  /// Конструктор [RatingPageRepository]
  RatingPageRepository(this._ratingPageClient);

  /// Возвращает данные страницы "Рейтинг"
  Future<RatingList?> getRatingList() => _ratingPageClient.getRatingList().then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные страницы поиска "Рейтинг"
  Future<SearchRatingList?> getSearchRatingList() =>
      _ratingPageClient.getSearchRatingList().then(
        (dto) {
          return null;
        },
      );
}
