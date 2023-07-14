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
  Future<List<Advice>> getUsefulData({
    required num limit,
    required num page,
  }) async {
    final body = <String, dynamic>{
      'limit': limit,
      'page': page,
    };
    late final List<Advice> res;
    await ExceptionHandler.shellException(() async {
      res = (await _usefulPageRepository.getUsefulData(body))!;
      return res;
    });
    return res;
  }
}
