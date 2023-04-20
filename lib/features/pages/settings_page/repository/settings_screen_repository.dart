import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/api/client.dart';

/// Репозиторий для главной
class SettingsPageRepository {
  final SettingsPageClient _settingsPageClient;

  /// Конструктор [SettingsPageRepository]
  SettingsPageRepository(this._settingsPageClient);

  /// Возвращает данные страницы информация
  Future<CharactersInfo?> getCharactersInfo() =>
      _settingsPageClient.getCharactersInfo().then(
        (dto) {
          return null;
        },
      );
}
