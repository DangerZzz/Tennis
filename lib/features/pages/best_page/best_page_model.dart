import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list.dart';
import 'package:soft_weather_tennis/features/pages/best_page/repository/best_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

///
class BestPageModel extends ElementaryModel {
  final BestPageRepository _bestPageRepository;

  /// Конструктор [BestPageModel]
  BestPageModel(
    this._bestPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных страницы
  Future<List<BestData>> getBestListData() async {
    late final List<BestData> res;
    await ExceptionHandler.shellException(() async {
      res = await _bestPageRepository.getBestListData();
      // return res;
    });
    return res;
  }
}
