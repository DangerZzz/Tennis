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
  Future<RatingList> getRatingList({required num page}) async {
    final body = <String, dynamic>{
      'limit': 10,
      'page': page,
      // 'search': '1231',
    };
    late final RatingList res;
    await ExceptionHandler.shellException(() async {
      res = (await _ratingPageRepository.getRatingList(body))!;
    });
    return res;
  }

  /// Получение рейтинга для поиска
  Future<SearchRatingList> getSearchingRatingList({
    required num page,
    required String search,
  }) async {
    final body = <String, dynamic>{
      'limit': 10,
      'page': page,
      'search': search,
    };
    late final SearchRatingList res;
    await ExceptionHandler.shellException(() async {
      res = (await _ratingPageRepository.getSearchRatingList(body))!;
      return res;
    });
    return res;
  }
}
