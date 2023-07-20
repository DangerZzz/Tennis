import 'package:soft_weather_tennis/features/pages/rating_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list_data_mapper.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/search_rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/dto/rating_list_dto.dart';

/// Репозиторий для главной
class RatingPageRepository {
  final RatingPageClient _ratingPageClient;

  /// Конструктор [RatingPageRepository]
  RatingPageRepository(this._ratingPageClient);

  /// Возвращает данные страницы "Рейтинг"
  Future<RatingList?> getRatingList(Map<String, dynamic> body) =>
      _ratingPageClient.getRatingList(body).then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <Rating>[];
          for (final element in data) {
            items.add(ratingListDataMapper(
              RatingListDtO.fromJson(element as Map<String, dynamic>),
            ));
          }
          return RatingList(
            ratingData: items,
          );
        },
      );

  /// Возвращает данные страницы поиска "Рейтинг"
  Future<SearchRatingList?> getSearchRatingList(Map<String, dynamic> body) =>
      _ratingPageClient.getRatingList(body).then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <Rating>[];
          for (final element in data) {
            items.add(ratingListDataMapper(
              RatingListDtO.fromJson(element as Map<String, dynamic>),
            ));
          }
          return SearchRatingList(
            ratingData: items,
            probablyRatingData: [],
          );
        },
      );
}
