import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_player_info.dart';
import 'package:soft_weather_tennis/features/pages/game_page/repository/game_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for ProPlayerInfoPage module
class ProPlayerInfoPageModel extends ElementaryModel {
  ///
  final GamePageRepository _gamePageRepository;

  ///
  ProPlayerInfoPageModel(this._gamePageRepository, ErrorHandler errorHandler)
      : super(errorHandler: errorHandler);

  /// Получение данных страницы
  Future<ProPlayerInfoData> getProPlayerInfoData() async {
    late final ProPlayerInfoData res;
    await ExceptionHandler.shellException(() async {
      res = (await _gamePageRepository.getProPlayerInfoData())!;
      return res;
    });
    return res;
  }
}
