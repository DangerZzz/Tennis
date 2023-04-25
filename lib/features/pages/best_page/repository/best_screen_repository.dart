import 'package:soft_weather_tennis/features/pages/best_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list.dart';

/// Репозиторий для главной
class BestPageRepository {
  final BestPageClient _bestPageClient;

  /// Конструктор [BestPageRepository]
  BestPageRepository(this._bestPageClient);

  /// Возвращает данные страницы лучшие
  Future<BestDataList?> getBestListData() =>
      _bestPageClient.getBestListData().then(
        (dto) {
          return null;
        },
      );
}
