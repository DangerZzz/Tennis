import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/domain/avatar_images.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for AvatarPage module
class AvatarPageModel extends ElementaryModel {
  final SettingsPageRepository _settingsPageRepository;

  ///
  AvatarPageModel(
    this._settingsPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных вкладки "аватар"
  Future<AvatarImages> getAvatarsData() async {
    late final AvatarImages res;
    await ExceptionHandler.shellException(() async {
      res = (await _settingsPageRepository.getAvatarsData())!;
      return res;
    });
    return res;
  }

  /// Получение данных вкладки "аватар"
  Future<void> uploadAvatar({
    required String type,
    required File file,
  }) async {
    await ExceptionHandler.shellException(() async {
      await _settingsPageRepository.uploadAvatar(type: type, file: file);
    });
  }
}
