import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for SettingsPage module
class SettingsPageModel extends ElementaryModel {
  final SettingsPageRepository _settingsPageRepository;

  /// Конструктор [SettingsPageModel]
  SettingsPageModel(
    this._settingsPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Получение данных вкладки "информация"
  Future<CharactersInfo> getCharactersInfo() async {
    late final CharactersInfo res;
    await ExceptionHandler.shellException(() async {
      res = (await _settingsPageRepository.getCharactersInfo())!;
      return res;
    });
    return res;
  }
}
