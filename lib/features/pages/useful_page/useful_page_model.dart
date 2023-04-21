import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/useful_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for UsefulPage module
class UsefulPageModel extends ElementaryModel {
  final UsefulPageRepository _usefulPageRepository;

  /// Конструктор [UsefulPageModel]
  UsefulPageModel(
    this._usefulPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных страницы
  Future<UsefulData> getUsefulData() async {
    late final UsefulData res;
    await ExceptionHandler.shellException(() async {
      res = (await _usefulPageRepository.getUsefulData())!;
      return res;
    });
    return res;
  }
}
