import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/repository/trainer_page_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for TrainerPage module
class TrainerPageModel extends ElementaryModel {
  final TrainerPageRepository _trainerPageRepository;

  ///
  TrainerPageModel(this._trainerPageRepository, ErrorHandler errorHandler)
      : super(errorHandler: errorHandler);

  /// Получение данных пользователя
  Future<UserInfo> getUserInfo() async {
    late final UserInfo res;
    await ExceptionHandler.shellException(() async {
      res = (await _trainerPageRepository.getUserInfo())!;
      return res;
    });
    return res;
  }
}
