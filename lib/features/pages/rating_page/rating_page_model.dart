import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/repository/rating_screen_repository.dart';

/// Default Elementary model for RatingPage module
class RatingPageModel extends ElementaryModel {
  final RatingPageRepository _ratingPageRepository;

  /// Конструктор [RatingPageModel]
  RatingPageModel(
    this._ratingPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
