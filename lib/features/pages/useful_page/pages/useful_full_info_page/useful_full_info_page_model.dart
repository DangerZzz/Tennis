import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_info.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/useful_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for UsefulFullInfoPage module
class UsefulFullInfoPageModel extends ElementaryModel {
  final UsefulPageRepository _usefulPageRepository;

  ///
  UsefulFullInfoPageModel(
    this._usefulPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных страницы
  Future<UsefulInfoData> usefulDataByIndex(String index) async {
    late final UsefulInfoData res;
    await ExceptionHandler.shellException(() async {
      res = (await _usefulPageRepository.usefulDataByIndex(index))!;
      return res;
    });
    return res;
  }
}
