import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/characteristics_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/characteristics_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/di/characteristics_page_scope.dart';

///
abstract class ICharacteristicsPageWidgetModel extends IWidgetModel {
  /// Данные пользователя с бэка
  ListenableState<EntityState<CharactersInfo>> get charactersInfo;

  /// Кнопка "назад"
  void onBack();
}

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

  @override
  ListenableState<EntityState<CharactersInfo>> get charactersInfo =>
      _charactersInfo;

  late EntityStateNotifier<CharactersInfo> _charactersInfo;

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
  void onBack() {
    coordinator.pop();
  }

  Future<void> _initLoad() async {
    _charactersInfo = EntityStateNotifier<CharactersInfo>();
    _charactersInfo.loading();
    final res = await model.getCharactersInfo();
    _charactersInfo.content(res);
  }
}
