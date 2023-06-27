import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/di/new_game_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';

///
abstract class INewGamePageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Контролер страницы
  ListenableState<EntityState<int>> get countdownTime;

  /// текущий сет
  ListenableState<EntityState<int>> get currentSet;

  /// Данные вкладки "тренировка"
  ListenableState<EntityState<TrainingInfo>> get workoutData;

  /// список игр текущего сета
  List<Game> get gameListData;

  /// текущая гейм
  ListenableState<EntityState<int>> get currentGame;

  ///
  double get width;

  ///
  double get height;

  ///
  void onStartGame();

  ///Кнопка "назад"
  void onBackWithIndex();

  ///Кнопка "назад"
  void onBack();

  /// изменение текущего сета
  void changeSet(int set);

  /// изменение текущего гейма
  void changeGame(int game);

  ///
  String countdown(int countdownTime);
}

///
NewGamePageWidgetModel defaultNewGamePageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<INewGamePageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.newGamePageModel;
  return NewGamePageWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for NewGamePageWidget
class NewGamePageWidgetModel
    extends WidgetModel<NewGamePageWidget, NewGamePageModel>
    implements INewGamePageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  ///
  final timer = Timer(Duration.zero, () {});

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  double get height => MediaQuery.of(context).size.height;

  @override
  ListenableState<EntityState<int>> get currentSet => _currentSet;

  @override
  ListenableState<EntityState<TrainingInfo>> get workoutData => _workoutData;

  @override
  List<Game> get gameListData => _gameListData;

  @override
  ListenableState<EntityState<int>> get currentGame => _currentGame;

  @override
  ListenableState<EntityState<int>> get index => _index;

  @override
  ListenableState<EntityState<int>> get countdownTime => _countdownTime;

  late EntityStateNotifier<int> _index;
  late EntityStateNotifier<int> _countdownTime;
  late EntityStateNotifier<int> _currentSet;
  late EntityStateNotifier<TrainingInfo> _workoutData;
  late List<Game> _gameListData = [];
  late EntityStateNotifier<int> _currentGame;

  /// Конструктор
  NewGamePageWidgetModel(
    NewGamePageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    timer.cancel();
  }

  /// изменение текущего сета
  @override
  void changeSet(int set) {
    if (set > (_currentSet.value?.data ?? 0)) {
      if (set < (workoutData.value?.data?.sets.length ?? 0)) {
        _currentSet.content(set);
        _gameListData = [];
        _gameListData = workoutData.value?.data?.sets[set].game ?? [];
      }
      return;
    }

    if (set < (_currentSet.value?.data ?? 0)) {
      if (set >= 0) {
        _currentSet.content(set);
        _gameListData = [];
        _gameListData = workoutData.value?.data?.sets[set].game ?? [];
      }
      return;
    }
  }

  /// изменение текущего гейма
  @override
  void changeGame(int game) {
    if ((_currentGame.value?.data ?? 0) + 1 == game) {
      return;
    }
    _currentGame.content(game - 1);
  }

  @override
  Future<void> onStartGame() async {
    _workoutData.loading();
    final res = await model.getTrainingData();
    _workoutData.content(res);
    _gameListData = workoutData.value?.data?.sets[0].game ?? [];
    _index.content(2);
    await startTimer();
  }

  @override
  Future<void> onBackWithIndex() async {
    var tempIndex = _index.value?.data ?? 1;
    if (tempIndex == 3) {
      _countdownTime.content(0);
      timer.cancel();
    }
    tempIndex--;
    _index.content(tempIndex);
  }

  @override
  Future<void> onBack() async {
    coordinator.pop();
  }

  @override
  String countdown(int countdownTime) {
    final min = countdownTime ~/ 60;
    final sec = countdownTime % 60;
    '$sec'.padLeft(2, '0');
    return '$min:${sec < 10 ? '0' : ''}$sec';
  }

  // TODO(daniil): переделать
  ///
  Future<void> firstPageTemp() async {
    _index.content(0);
    await Future<void>.delayed(const Duration(seconds: 5));
    await secondPageTemp();
  }

  // TODO(daniil): переделать
  ///
  Future<void> secondPageTemp() async {
    _index.content(1);
  }

  ///
  Future<void> startTimer() async {
    _countdownTime.content(1000);
    var countdown = _countdownTime.value?.data ?? 0;
    while ((_countdownTime.value?.data ?? 0) > 0) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (kDebugMode) {
        print(_countdownTime.value?.data);
      }
      countdown--;
      _countdownTime.content(countdown);
    }
    timer.cancel();
    if (_index.value?.data != null && _index.value?.data == 2) {
      await toHitch();
    }
  }

  ///
  Future<void> toHitch() async {
    _index.content(3);
    await startTimer();
  }

  Future<void> _initLoad() async {
    _index = EntityStateNotifier<int>();
    _currentSet = EntityStateNotifier<int>();
    _currentSet.content(0);
    _workoutData = EntityStateNotifier<TrainingInfo>();
    _currentGame = EntityStateNotifier<int>();
    _currentGame.content(0);
    _countdownTime = EntityStateNotifier<int>();
    await onStartGame();
  }
}
