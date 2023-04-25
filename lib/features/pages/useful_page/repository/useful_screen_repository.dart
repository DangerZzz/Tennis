import 'package:soft_weather_tennis/features/pages/useful_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';

/// Репозиторий для главной
class UsefulPageRepository {
  final UsefulPageClient _usefulPageClient;

  /// Конструктор [UsefulPageRepository]
  UsefulPageRepository(this._usefulPageClient);

  /// Возвращает данные страницы полезное
  Future<UsefulData?> getUsefulData() => _usefulPageClient.getUsefulData().then(
        (dto) {
          return null;
        },
      );
}
