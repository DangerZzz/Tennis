import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/search_rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/repository/rating_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for RatingPage module
class RatingPageModel extends ElementaryModel {
  final RatingPageRepository _ratingPageRepository;

  /// Конструктор [RatingPageModel]
  RatingPageModel(
    this._ratingPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение рейтинга
  Future<RatingList> getRatingList() async {
    late final RatingList res;
    await ExceptionHandler.shellException(() async {
      res = (await _ratingPageRepository.getRatingList())!;
      return res;
    });
    return res;
  }

  /// Получение рейтинга для поиска
  Future<SearchRatingList> getSearchingRatingList() async {
    late final SearchRatingList res;
    await ExceptionHandler.shellException(() async {
      res = (await _ratingPageRepository.getSearchRatingList())!;
      return res;
    });
    return res;
  }
}
