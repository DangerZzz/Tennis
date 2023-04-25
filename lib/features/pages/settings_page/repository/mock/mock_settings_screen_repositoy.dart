import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/domain/avatar_images.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';

/// mock repository
class MockSettingsPageRepository implements SettingsPageRepository {
  ///
  @override
  Future<CharactersInfo> getCharactersInfo() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return CharactersInfo(
      height: '',
      age: '',
      ageInTennis: '',
      backhand: '',
      forehand: '',
      technicality: '',
      trainer: '',
    );
  }

  @override
  Future<AvatarImages> getAvatarsData() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return AvatarImages(
      avatarClippedUrl: '',
      avatarUrl: '',
      backImageClippedUrl: '',
      backImageUrl: '',
    );
  }
}
