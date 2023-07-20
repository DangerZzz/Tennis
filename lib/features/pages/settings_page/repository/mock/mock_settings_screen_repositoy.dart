import 'dart:io';

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
      height: 0,
      age: 0,
      ageInTennis: 0,
      backhand: '',
      forehand: '',
      technicality: 0,
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

  @override
  Future<void> changeName(Map<String, dynamic> body) async {}

  @override
  Future<void> editCharactersInfo(Map<String, dynamic> body) async {}

  @override
  Future<void> exit() async {}

  @override
  Future<void> uploadAvatar({required String type, required File file}) async {}
}
