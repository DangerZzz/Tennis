import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/repository/trainer_page_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for TrainerGamePage module
class TrainerGamePageModel extends ElementaryModel {
  final TrainerPageRepository _trainerPageRepository;

  ///
  TrainerGamePageModel(
    this._trainerPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// отправка данных с qr-кода
  Future<String> sendQrData({
    required String connect,
  }) async {
    final body = <String, dynamic>{
      'connect': connect,
    };
    late String res;
    await ExceptionHandler.shellException(() async {
      res = await _trainerPageRepository.sendQrData(body);
      return res;
    });
    return res;
  }
}
