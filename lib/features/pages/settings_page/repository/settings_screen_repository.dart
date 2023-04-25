import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/domain/avatar_images.dart';

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

  /// Возвращает данные страницы аватар
  Future<AvatarImages?> getAvatarsData() =>
      _settingsPageClient.getAvatarsData().then(
        (dto) {
          return null;
        },
      );
}
