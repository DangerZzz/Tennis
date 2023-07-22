import 'package:dio/dio.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/user_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/domain/avatar_images.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/dto/avatar_data_dto.dart';

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
          final data = AvatarDataDtO.fromJson(dto.data as Map<String, dynamic>);

          return AvatarImages(
            avatarUrl: data.originalAvatar?.src ?? '',
            backImageUrl: data.originalWallpaper?.src ?? '',
            backImageClippedUrl: data.wallpaper?.src ?? '',
            avatarClippedUrl: data.avatar?.src ?? '',
            id: data.id,
          );
        },
      );

  /// Возвращает данные страницы аватар
  Future<void> deleteAvatarData({
    required String type,
    required String id,
  }) =>
      _settingsPageClient
          .deleteAvatarData(
        '/api/file/user/$type/$id',
      )
          .then(
        (dto) {
          return null;
        },
      );

  /// Возвращает данные страницы аватар
  Future<void> uploadAvatar({
    required String type,
    required FormData body,
  }) =>
      _settingsPageClient.uploadAvatar('/api/file/user/$type', body).then(
        (dto) {
          return null;
        },
      );

  /// Изменение имени
  Future<void> changeName(Map<String, dynamic> body) =>
      _settingsPageClient.changeName(body).then(
            (dto) {},
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
