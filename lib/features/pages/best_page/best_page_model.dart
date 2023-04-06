import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/best_page/repository/best_screen_repository.dart';

///
class BestPageModel extends ElementaryModel {
  final BestPageRepository _bestPageRepository;

  /// Конструктор [BestPageModel]
  BestPageModel(
    this._bestPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
