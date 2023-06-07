import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for NewGamePage module
class NewGamePageModel extends ElementaryModel {
  final GamePageRepository _gamePageRepository;

  ///
  NewGamePageModel(
    this._gamePageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных вкладки "тренировка"
  Future<TrainingInfo> getTrainingData() async {
    late final TrainingInfo res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getTrainingData())!;
      return res;
    });
    return res;
  }
}
