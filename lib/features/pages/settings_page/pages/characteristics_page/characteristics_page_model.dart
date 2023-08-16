import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/repository/settings_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for CharacteristicsPage module
class CharacteristicsPageModel extends ElementaryModel {
  final SettingsPageRepository _settingsPageRepository;

  ///
  CharacteristicsPageModel(
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

  /// Изменение данных
  Future<void> editCharactersInfo({
    required num age,
    required num height,
    required num ageInTennis,
    required String backhand,
    required String forehand,
  }) async {
    final body = <String, dynamic>{
      'age': age,
      'height': height,
      'tennis_year': ageInTennis,
      'forehand': forehand,
      'backhand': backhand,
    };
    await ExceptionHandler.shellException(() async {
      await _settingsPageRepository.editCharactersInfo(body);
    });
    return;
  }
}
