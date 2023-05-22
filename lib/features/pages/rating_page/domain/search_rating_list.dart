import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';

///Сущность списка рейтинка для поиска
class SearchRatingList {
  /// Список данных рейтинга игроков
  final List<Rating> ratingData;

  /// Список "возможно вы искали"
  final List<Rating> probablyRatingData;

  ///конструктор [SearchRatingList]
  SearchRatingList({
    required this.ratingData,
    required this.probablyRatingData,
  });
}
