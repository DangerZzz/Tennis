import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/useful_screen_repository.dart';

/// Default Elementary model for UsefulPage module
class UsefulPageModel extends ElementaryModel {
  final UsefulPageRepository _usefulPageRepository;

  /// Конструктор [UsefulPageModel]
  UsefulPageModel(
    this._usefulPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
