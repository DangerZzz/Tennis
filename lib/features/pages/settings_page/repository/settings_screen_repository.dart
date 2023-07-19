import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/user_data_dto.dart';
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
          final data = UserDataDtO.fromJson(dto.data as Map<String, dynamic>);

          return CharactersInfo(
            age: data.user?.characteristics?.age ?? 0,
            height: data.user?.characteristics?.height ?? 0,
            ageInTennis: data.user?.characteristics?.tennisYear ?? 0,
            forehand: data.user?.characteristics?.forehand ?? '',
            backhand: data.user?.characteristics?.backhand ?? '',
            technicality: data.user?.characteristics?.technicality ?? 0,
            trainer: data.user?.characteristics?.trainer ?? '',
          );
        },
      );

  /// Возвращает данные страницы аватар
  Future<AvatarImages?> getAvatarsData() =>
      _settingsPageClient.getAvatarsData().then(
        (dto) {
          return null;
        },
      );

  /// Изменение имени
  Future<void> changeName(Map<String, dynamic> body) =>
      _settingsPageClient.changeName(body).then(
        (dto) {
          return null;
        },
      );

  /// Изменение имени
  Future<void> editCharactersInfo(Map<String, dynamic> body) =>
      _settingsPageClient.editCharactersInfo(body).then(
        (dto) {
          return null;
        },
      );

  /// Изменение имени
  Future<void> exit() => _settingsPageClient.exit().then(
        (dto) {
          return null;
        },
      );
}
