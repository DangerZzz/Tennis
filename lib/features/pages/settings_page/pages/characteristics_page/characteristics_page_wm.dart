import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/components/snack_bar.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/widgets/adaptive_date_picker.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/characteristics_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/characteristics_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/di/characteristics_page_scope.dart';

///
abstract class ICharacteristicsPageWidgetModel extends IWidgetModel {
  /// Данные пользователя с бэка
  ListenableState<EntityState<CharactersInfo>> get charactersInfo;

  ///
  List<String> get height;

  /// Кнопка "сохранить"
  void editCharacters();

  /// Кнопка "назад"
  void onBack();

  /// Нажатие на возраст
  void onAge();

  /// Нажатие на возраст
  void onAgeInTennis();

  /// Нажатие на forehand
  void forehandEdit(String state);

  /// Нажатие на backhand
  void backhandEdit(String state);

  /// Нажатие на height
  void heightEdit(String state);
}

///
CharacteristicsPageWidgetModel defaultCharacteristicsPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<ICharacteristicsPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.characteristicsPageModel;
  return CharacteristicsPageWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for CharacteristicsPageWidget
class CharacteristicsPageWidgetModel
    extends WidgetModel<CharacteristicsPageWidget, CharacteristicsPageModel>
    implements ICharacteristicsPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;
  final List<String> _height = [];

  @override
  ListenableState<EntityState<CharactersInfo>> get charactersInfo =>
      _charactersInfo;

  @override
  List<String> get height => _height;

  late EntityStateNotifier<CharactersInfo> _charactersInfo;
  var _sendRequest = false;

  ///
  CharacteristicsPageWidgetModel(
    CharacteristicsPageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  ///
  @override
  Future<void> editCharacters() async {
    if (!_sendRequest) {
      _sendRequest = true;
      try {
        await model.editCharactersInfo(
          age: _charactersInfo.value?.data?.age ?? 0,
          ageInTennis: _charactersInfo.value?.data?.ageInTennis ?? 0,
          height: _charactersInfo.value?.data?.height ?? 0,
          forehand: _charactersInfo.value?.data?.forehand ?? '',
          backhand: _charactersInfo.value?.data?.backhand ?? '',
        );
        onBack();
      } on FormatException catch (e) {
        //ignore:use_build_context_synchronously
        ShowSnackBar().showError(context);
      }
      _sendRequest = false;
    }
  }

  @override
  void onBack() {
    coordinator.pop();
  }

  @override
  Future<void> onAge() async {
    final res = await showAdaptiveDatePicker(
      context,
      title: 'Возраст',
      maximumDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      fromDate: DateTime.now().subtract(const Duration(days: 366 * 5)),
      minimumDate: DateTime(
        1930,
      ),
    );
    if (res != null) {
      final age = DateTime.now().year - res.year;
      final tempCharacters = _charactersInfo.value;
      _charactersInfo.content(
        CharactersInfo(
          height: tempCharacters?.data?.height,
          age: age,
          ageInTennis: tempCharacters?.data?.ageInTennis,
          backhand: tempCharacters?.data?.backhand,
          forehand: tempCharacters?.data?.forehand,
          technicality: tempCharacters?.data?.technicality,
          trainer: tempCharacters?.data?.trainer,
        ),
      );
    }
  }

  @override
  Future<void> onAgeInTennis() async {
    final res = await showAdaptiveDatePicker(
      context,
      title: 'Лет в теннисе',
      maximumDate: DateTime.now(),
      fromDate: DateTime.now().subtract(const Duration(minutes: 1)),
      minimumDate: DateTime(
        1950,
      ),
    );
    if (res != null) {
      final ageInTennis = DateTime.now().year - res.year;
      final tempCharacters = _charactersInfo.value;
      _charactersInfo.content(
        CharactersInfo(
          height: tempCharacters?.data?.height,
          age: tempCharacters?.data?.age,
          ageInTennis: ageInTennis,
          backhand: tempCharacters?.data?.backhand,
          forehand: tempCharacters?.data?.forehand,
          technicality: tempCharacters?.data?.technicality,
          trainer: tempCharacters?.data?.trainer,
        ),
      );
    }
  }

  @override
  Future<void> forehandEdit(String state) async {
    final tempCharacters = _charactersInfo.value;
    _charactersInfo.content(
      CharactersInfo(
        height: tempCharacters?.data?.height,
        age: tempCharacters?.data?.age,
        ageInTennis: tempCharacters?.data?.ageInTennis,
        backhand: tempCharacters?.data?.backhand,
        forehand: state == 'Левая рука' ? 'LEFT' : 'RIGHT',
        technicality: tempCharacters?.data?.technicality,
        trainer: tempCharacters?.data?.trainer,
      ),
    );
  }

  @override
  Future<void> backhandEdit(String state) async {
    final tempCharacters = _charactersInfo.value;
    _charactersInfo.content(
      CharactersInfo(
        height: tempCharacters?.data?.height,
        age: tempCharacters?.data?.age,
        ageInTennis: tempCharacters?.data?.ageInTennis,
        backhand: state == 'Одноручный' ? 'ONE' : 'TWO',
        forehand: tempCharacters?.data?.forehand,
        technicality: tempCharacters?.data?.technicality,
        trainer: tempCharacters?.data?.trainer,
      ),
    );
  }

  @override
  Future<void> heightEdit(String state) async {
    final tempCharacters = _charactersInfo.value;
    _charactersInfo.content(
      CharactersInfo(
        height: int.parse(state.split(' ')[0]),
        age: tempCharacters?.data?.age,
        ageInTennis: tempCharacters?.data?.ageInTennis,
        backhand: tempCharacters?.data?.backhand,
        forehand: tempCharacters?.data?.forehand,
        technicality: tempCharacters?.data?.technicality,
        trainer: tempCharacters?.data?.trainer,
      ),
    );
  }

  Future<void> _initLoad() async {
    var i = 80;
    while (i < 210) {
      _height.add('${i.toString()} см');
      i++;
    }
    _charactersInfo = EntityStateNotifier<CharactersInfo>();
    _charactersInfo.loading();
    try {
      final res = await model.getCharactersInfo();
      _charactersInfo.content(res);
    } on FormatException catch (e) {
      //ignore:use_build_context_synchronously
      ShowSnackBar().showError(context);
    }
  }
}
