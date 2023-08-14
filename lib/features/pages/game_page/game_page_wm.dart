import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/di/game_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/player_call_page.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IGamePageWidgetModel extends IWidgetModel {
  /// Все данные страницы
  ListenableState<EntityState<GameData>> get gameData;

  /// Состояние кнопки
  ListenableState<EntityState<bool>> get statisticsButtonLoadingState;

  /// Обновление страницы
  Future<void> onRefresh();

  /// Перход на страницу про игроков
  void toAllProPlayers();

  ///  Начало игры
  void toStartGame();

  ///  Информация про игрока
  void toProPlayerInfo(ProPlayer player);

  ///  переход в статистику
  void toStatistics();

  ///  повторить тренировку
  void repeatTraining({required int index});
}

///
GamePageWidgetModel defaultGamePageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IGamePageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.gamePageModel;
  return GamePageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for GamePageWidget
class GamePageWidgetModel extends WidgetModel<GamePageWidget, GamePageModel>
    implements IGamePageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  ///
  final currentLevel = [0, ''];

  final UserNotifier _userNotifier;

  @override
  ListenableState<EntityState<GameData>> get gameData => _gameData;

  @override
  ListenableState<EntityState<bool>> get statisticsButtonLoadingState =>
      _statisticsButtonLoadingState;

  late EntityStateNotifier<GameData> _gameData;
  late EntityStateNotifier<bool> _statisticsButtonLoadingState;
  late EntityStateNotifier<bool> _isLoadingProPage;

  /// Конструктор
  GamePageWidgetModel(
    GamePageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _gameData = EntityStateNotifier<GameData>();
    _isLoadingProPage = EntityStateNotifier<bool>();
    _statisticsButtonLoadingState = EntityStateNotifier<bool>();
    await _initLoad();
  }

  @override
  Future<void> onRefresh() async {
    _gameData.loading();
    await Future<void>.delayed(const Duration(seconds: 1));
    await _initLoad();
  }

  @override
  Future<void> toAllProPlayers() async {
    coordinator.navigate(
      context,
      AppCoordinate.proPlayerInfoPage,
    );
  }

  @override
  Future<void> toStartGame() async {
    coordinator.navigate(
      context,
      AppCoordinate.newGamePage,
      arguments: [
        currentLevel[0],
        currentLevel[1],
      ],
    );
  }

  @override
  Future<void> toProPlayerInfo(ProPlayer player) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => PlayerCallPage(
          proPlayer: player,
        ),
      ),
    );
  }

  @override
  Future<void> toStatistics() async {
    coordinator.navigate(
      context,
      AppCoordinate.statisticInGamePage,
    );
  }

  @override
  Future<void> repeatTraining({required int index}) async {
    // coordinator.navigate(
    //   context,
    //   AppCoordinate.usefulFullInfoPage,
    //   arguments: index,
    // );
  }

  Future<void> _initLoad() async {
    _gameData.loading();
    _statisticsButtonLoadingState.content(false);
    _isLoadingProPage.content(false);

    try {
      final gamesData = await model.getTrainingsData();
      final playersData = await model.getProPlayerData(
        limit: 2,
        page: 1,
      );
      if (_userNotifier.currentLevel != 0) {
        currentLevel[0] = _userNotifier.currentLevel;
        currentLevel[1] = _userNotifier.currentComplexity;
      } else {
        final res = await model.getGameData();
        currentLevel[0] = res.maxLevel;
        currentLevel[1] = res.maxComplexity;
      }
      _gameData.content(
        GameData(
          proPlayers: playersData,
          trainings: gamesData,
          currentLevel: currentLevel[0] as num,
          currentComplexity: '${(currentLevel[1] as String).substring(0, 1)}'
              '${(currentLevel[1] as String).substring(1).toLowerCase()}',
        ),
      );
    } on FormatException catch (e) {
      _gameData.error(e);
    }
  }
}
