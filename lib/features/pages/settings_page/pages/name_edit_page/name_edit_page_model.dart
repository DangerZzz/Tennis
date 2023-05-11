import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';

/// Default Elementary model for NameEditPage module
class NameEditPageModel extends ElementaryModel {
  final SettingsPageRepository _settingsPageRepository;

  ///
  NameEditPageModel(
    this._settingsPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
