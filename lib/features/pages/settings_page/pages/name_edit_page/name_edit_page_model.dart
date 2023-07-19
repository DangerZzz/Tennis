import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for NameEditPage module
class NameEditPageModel extends ElementaryModel {
  final SettingsPageRepository _settingsPageRepository;

  ///
  NameEditPageModel(
    this._settingsPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Изменение имени
  Future<void> changeName({
    required String name,
    required String surname,
  }) async {
    final body = <String, dynamic>{
      'name': name,
      'surname': surname,
    };
    await ExceptionHandler.shellException(() async {
      await _settingsPageRepository.changeName(body);
    });
    return;
  }
}
