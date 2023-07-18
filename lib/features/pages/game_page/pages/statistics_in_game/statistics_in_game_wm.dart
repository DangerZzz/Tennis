import 'package:elementary/elementary.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/di/statistics_in_game_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/statistics_in_game_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/statistics_in_game_widget.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/widgets/adaptive_date_picker.dart';

///
abstract class IStatisticsInGameWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Данные вкладки "статистика"
  ListenableState<EntityState<StatisticsList>> get statisticsData;

  /// Данные вкладки "тренировка"
  ListenableState<EntityState<TrainingInfo>> get workoutData;

  /// текущий сет
  ListenableState<EntityState<int>> get currentSet;

  /// текущая гейм
  ListenableState<EntityState<int>> get currentGame;

  /// Ширина страницы
  double get width;

  /// Точки на графике
  List<FlSpot> get spots;

  /// список игр текущего сета
  List<Game> get gameListData;

  /// Значения Y
  String yAxisClean(int index);

  /// Нажатие на вкладку "Статистика"
  void onStatistics();

  /// Нажатие на нкопку назад
  void back();

  /// Повторить тренировку
  void toStartGame();

  /// Нажатие на календарь на вкладке "Статистика"
  void onCalendar();

  /// Переход на статистику дня
  void onWorkoutInformation(int date);

  /// изменение текущего сета
  void changeSet(int set);

  /// изменение текущего гейма
  void changeGame(int game);
}

///
StatisticsInGameWidgetModel defaultStatisticsInGameWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IStatisticsInGameScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.statisticsInGameModel;
  return StatisticsInGameWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for StatisticsInGameWidget
class StatisticsInGameWidgetModel
    extends WidgetModel<StatisticsInGameWidget, StatisticsInGameModel>
    implements IStatisticsInGameWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  List<FlSpot> get spots => _spots;

  @override
  ListenableState<EntityState<int>> get index => _index;

  @override
  ListenableState<EntityState<StatisticsList>> get statisticsData =>
      _statisticsData;

  @override
  ListenableState<EntityState<TrainingInfo>> get workoutData => _workoutData;

  @override
  ListenableState<EntityState<int>> get currentSet => _currentSet;

  @override
  ListenableState<EntityState<int>> get currentGame => _currentGame;

  @override
  List<Game> get gameListData => _gameListData;

  late EntityStateNotifier<StatisticsList> _statisticsData;
  late EntityStateNotifier<TrainingInfo> _workoutData;
  late EntityStateNotifier<int> _index;
  late EntityStateNotifier<int> _currentSet;
  late EntityStateNotifier<int> _currentGame;
  late List<FlSpot> _spots = [];
  late List<Game> _gameListData = [];

  ///
  StatisticsInGameWidgetModel(
    StatisticsInGameModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  @override
  Future<void> back() async {
    if (_index.value?.data != 0) {
      _index.content(0);
    } else {
      coordinator.pop();
    }
  }

  @override
  Future<void> onStatistics() async {
    _index.content(0);
    _statisticsData.loading();
    final res = await model.getStatisticsData();
    _spots = [];

    for (var index = 0; index < res.efficiencyList.length; index++) {
      if (res.efficiencyList.length == 1) {
        _spots.add(
          FlSpot.zero,
        );
      }
      var indexClean = index.toDouble();
      if (res.efficiencyList.length == 1) {
        indexClean = index + 1;
      }
      _spots.add(
        FlSpot(
          indexClean,
          res.efficiencyList[index].efficiency.toDouble(),
        ),
      );
    }

    _statisticsData.content(res);
  }

  @override
  Future<void> onWorkoutInformation(int date) async {
    _index.content(1);

    _workoutData.loading();
    final res = await model.getTrainingData();
    _workoutData.content(res);
    _gameListData = workoutData.value?.data?.sets[0].game ?? [];
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
  Future<void> onCalendar() async {
    var text = '';
    final res = await showAdaptiveDatePicker(
      context,
      title: 'Дата тренировки',
      maximumDate: DateTime.now(),
      fromDate: DateTime.now().subtract(const Duration(minutes: 1)),
      minimumDate: DateTime(
        1970,
      ),
    );
    if (res != null) {
      final a = res.millisecondsSinceEpoch;
      text = '${res.day}.${res.month}.${res.year}';
      await onWorkoutInformation(a);
    }
  }

  @override
  String yAxisClean(int date) {
    var text = '';
    var checkData = date;
    // if (date < 10 && _statisticsData.value?.data?.efficiencyList.length != 1) {
    //   checkData =
    //       _statisticsData.value?.data?.efficiencyList[date].date.toInt() ?? 0;
    // }
    // if (_statisticsData.value?.data?.efficiencyList.length == 1) {
    //   checkData =
    //       _statisticsData.value?.data?.efficiencyList[0].date.toInt() ?? 0;
    // }
    final day =
        DateTime.fromMillisecondsSinceEpoch(checkData * 1000).toUtc().day;
    final month =
        DateTime.fromMillisecondsSinceEpoch(checkData * 1000).toUtc().month;
    if (month < 10) {
      text = '$day.0$month';
    } else {
      text = '$day.$month';
    }

    if (_statisticsData.value?.data?.efficiencyList.length == 1 && date == 0) {
      text = '';
    }
    return text;
  }

  @override
  Future<void> toStartGame() async {
    coordinator.navigate(
      context,
      AppCoordinate.newGamePage,
    );
  }

  Future<void> _initLoad() async {
    _index = EntityStateNotifier<int>();
    _index.content(0);
    _currentSet = EntityStateNotifier<int>();
    _currentSet.content(0);
    _currentGame = EntityStateNotifier<int>();
    _currentGame.content(0);
    _statisticsData = EntityStateNotifier<StatisticsList>();
    _workoutData = EntityStateNotifier<TrainingInfo>();

    await onStatistics();
  }
}
