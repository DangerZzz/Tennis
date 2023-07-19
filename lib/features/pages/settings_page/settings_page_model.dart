import 'package:elementary/elementary.dart';
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

  /// logout
  Future<void> exit() async {
    await ExceptionHandler.shellException(() async {
      await _settingsPageRepository.exit();
    });
    return;
  }
}
