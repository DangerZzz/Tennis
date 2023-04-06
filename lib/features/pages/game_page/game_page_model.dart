import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';

/// Default Elementary model for GamePage module
class GamePageModel extends ElementaryModel {
  final GamePageRepository _gamePageRepository;

  /// Конструктор [GamePageModel]
  GamePageModel(
    this._gamePageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
