import 'package:async/async.dart';
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
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_players_page.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IGamePageWidgetModel extends IWidgetModel {
  /// Все данные страницы
  ListenableState<EntityState<GameData>> get gameData;

  /// Флаг поиска
  ListenableState<EntityState<bool>> get isSearching;

  /// Флаг загрузки информации об игроке
  ListenableState<EntityState<bool>> get isLoadingProPage;

  /// Состояние кнопки
  ListenableState<EntityState<bool>> get allPlayersButtonLoadingState;

  /// Состояние кнопки
  ListenableState<EntityState<bool>> get statisticsButtonLoadingState;

  /// Данные страницы
  ListenableState<EntityState<List<ProPlayer>>> get searchedList;

  /// Контроллер текста поиска
  TextEditingController get searchController;

  /// Focus текста поиска
  FocusNode get searchFocusNode;

  /// Обновление страницы
  Future<void> onRefresh();

  /// Перход на страницу про игроков
  void toAllProPlayers();

  ///  Начало игры
  void toStartGame();

  ///  Начало игры
  void toProPlayerInfo(int? id);

  ///  переход в статистику
  void toStatistics();

  /// Нажатие на кнопку поиска
  void onSearchTap();

  /// Функция поиска
  Future<void> searching();

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

  final UserNotifier _userNotifier;

  @override
  ListenableState<EntityState<GameData>> get gameData => _gameData;

  @override
  ListenableState<EntityState<bool>> get isSearching => _isSearching;

  @override
  ListenableState<EntityState<bool>> get allPlayersButtonLoadingState =>
      _allPlayersButtonLoadingState;

  @override
  ListenableState<EntityState<bool>> get statisticsButtonLoadingState =>
      _statisticsButtonLoadingState;

  @override
  ListenableState<EntityState<bool>> get isLoadingProPage => _isLoadingProPage;

  @override
  ListenableState<EntityState<List<ProPlayer>>> get searchedList =>
      _searchedList;

  @override
  TextEditingController get searchController => _searchController;

  @override
  FocusNode get searchFocusNode => _searchFocusNode;

  late EntityStateNotifier<List<ProPlayer>> _searchedList;
  late EntityStateNotifier<bool> _isSearching;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  late EntityStateNotifier<GameData> _gameData;
  late EntityStateNotifier<bool> _allPlayersButtonLoadingState;
  late EntityStateNotifier<bool> _statisticsButtonLoadingState;
  late EntityStateNotifier<bool> _isLoadingProPage;

  CancelableOperation? _currentOperation;

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
    _isSearching = EntityStateNotifier<bool>();
    _isLoadingProPage = EntityStateNotifier<bool>();
    _allPlayersButtonLoadingState = EntityStateNotifier<bool>();
    _statisticsButtonLoadingState = EntityStateNotifier<bool>();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _searchedList = EntityStateNotifier<List<ProPlayer>>();
    await _initLoad();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Future<void> onRefresh() async {
    await _initLoad();
  }

  @override
  Future<void> toAllProPlayers() async {
    _allPlayersButtonLoadingState.content(true);

    final data = await model.getProPlayerData();
    //ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProPlayersPage(
          isSearching: _isSearching,
          onSearchTap: onSearchTap,
          proPlayers: data,
          searchedList: _searchedList,
          searchController: searchController,
          searchFocusNode: searchFocusNode,
          searching: searching,
          onInfo: () => toProPlayerInfo(1),
          toStartGame: toStartGame,
        ),
      ),
    );
    _allPlayersButtonLoadingState.content(false);
  }

  @override
  Future<void> toStartGame() async {
    coordinator.navigate(
      context,
      AppCoordinate.newGamePage,
    );
  }

  @override
  Future<void> toProPlayerInfo(int? id) async {
    coordinator.navigate(
      context,
      AppCoordinate.proPlayerInfoPage,
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

  @override
  Future<void> searching() async {
    _searchedList
      ..content(
        <ProPlayer>[],
      )
      ..loading();
    _currentOperation = CancelableOperation<List<ProPlayer>>.fromFuture(
      Future<List<ProPlayer>>(
        () async {
          final savedOperation = _currentOperation;
          await Future<void>.delayed(const Duration(seconds: 1));
          if (savedOperation?.isCanceled ?? false) {
            return <ProPlayer>[];
          }
          final result = await model.getProPlayerSearchData();
          return result;
        },
      ),
    );
    final data = await _currentOperation!.value as List<ProPlayer>;

    _searchedList.content(data);
  }

  @override
  void onSearchTap() {
    final isSearchActive = _isSearching.value?.data;
    _isSearching.content(!isSearchActive!);
  }

  Future<void> _initLoad() async {
    _gameData.loading();
    _isSearching.content(false);
    _allPlayersButtonLoadingState.content(false);
    _statisticsButtonLoadingState.content(false);
    _isLoadingProPage.content(false);
    _searchedList.content(
      <ProPlayer>[],
    );

    try {
      final data = await model.getGameData();
      _gameData.content(data);
    } on FormatException catch (e) {
      _gameData.error(e);
    }
  }
}
