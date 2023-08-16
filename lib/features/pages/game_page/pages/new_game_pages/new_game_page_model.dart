import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/preparing_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/domain/current_game_data.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for NewGamePage module
class NewGamePageModel extends ElementaryModel {
  final GamePageRepository _gamePageRepository;

  ///
  NewGamePageModel(
    this._gamePageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных подготовки к тренировке
  Future<PreparingData> getPreparingData({required String id}) async {
    final body = <String, dynamic>{
      '_id': id,
    };
    late final PreparingData res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getPreparingData(body))!;
      return res;
    });
    return res;
  }

  /// Получение данных пользователя
  Future<UserInfo> getUserInfo() async {
    late final UserInfo res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getUserInfo())!;
      return res;
    });
    return res;
  }

  /// Получение id
  Future<String> getInitialData({
    required String complexity,
    required num level,
  }) async {
    final body = <String, dynamic>{
      'complexity': complexity.toUpperCase(),
      'level': level,
    };
    late final String res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getInitialData(body))!;
      return res;
    });
    return res;
  }

  /// Получение qr
  Future<String> getQRData({
    required String id,
  }) async {
    final body = <String, dynamic>{
      '_id': id,
    };
    late final String res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getQRData(body))!;
      return res;
    });
    return res;
  }

  /// Начало игры
  Future<CurrentGameData?> gameStart({
    required String token,
  }) async {
    late CurrentGameData? res;
    await ExceptionHandler.shellException(() async {
      res = await _gamePageRepository.gameStart(token);
    });
    return res;
  }
}
