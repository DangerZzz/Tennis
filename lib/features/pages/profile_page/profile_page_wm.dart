import 'package:elementary/elementary.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/di/profile_scope.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/information.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_model.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/widgets/achievements_dialog.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/widgets/adaptive_date_picker.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IProfilePageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Данные пользователя
  ListenableState<EntityState<UserInfo>> get userInfo;

  /// Данные вкладки "информация"
  ListenableState<EntityState<Information>> get informationData;

  /// Данные вкладки "игра"
  ListenableState<EntityState<GameData>> get gameData;

  /// Данные вкладки "статистика"
  ListenableState<EntityState<StatisticsList>> get statisticsData;

  /// Данные вкладки "тренировка"
  ListenableState<EntityState<TrainingInfo>> get workoutData;

  /// текущий уровень
  ListenableState<EntityState<num>> get currentLevel;

  /// текущая сложность
  ListenableState<EntityState<String>> get currentComplexity;

  /// текущий сет
  ListenableState<EntityState<int>> get currentSet;

  /// текущая гейм
  ListenableState<EntityState<int>> get currentGame;

  /// состояние кнопки "достижения"
  ListenableState<EntityState<bool>> get achievementsButtonIsLoading;

  /// Ширина страницы
  double get width;

  /// Точки на графике
  List<FlSpot> get spots;

  /// Флаг наличия достижений
  bool get newAchievements;

  /// список игр текущего сета
  List<Game> get gameListData;

  /// Значения Y
  String yAxisClean(int index);

  /// Нажатие на вкладку "Информация"
  void onInformation();

  /// Нажатие на вкладку "Игра"
  void onGame();

  /// Нажатие на вкладку "Статистика"
  void onStatistics();

  /// Переход на страницу достижений
  void toAchievementsPage();

  /// Переход на страницу настроек
  void toSettingsPage();

  /// Нажатие на календарь на вкладке "Статистика"
  void onCalendar();

  /// Переход на статистику дня
  void onWorkoutInformation(int date);

  /// изменения уровня игры
  void changeCurrentLevel(num level);

  /// изменения сложности игры
  void changeCurrentComplexity(String complexity);

  /// изменение текущего сета
  void changeSet(int set);

  /// изменение текущего сета
  void changeGame(int game);
}

///
ProfilePageWidgetModel defaultProfilePageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IProfilePageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.profilePageModel;
  return ProfilePageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for ProfilePageWidget
class ProfilePageWidgetModel
    extends WidgetModel<ProfilePageWidget, ProfilePageModel>
    implements IProfilePageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  List<FlSpot> get spots => _spots;

  @override
  bool get newAchievements => false;

  @override
  List<Game> get gameListData => _gameListData;

  @override
  ListenableState<EntityState<int>> get index => _index;

  @override
  ListenableState<EntityState<num>> get currentLevel => _currentLevel;

  @override
  ListenableState<EntityState<String>> get currentComplexity =>
      _currentComplexity;

  @override
  ListenableState<EntityState<UserInfo>> get userInfo => _userInfo;

  @override
  ListenableState<EntityState<Information>> get informationData =>
      _informationData;

  @override
  ListenableState<EntityState<GameData>> get gameData => _gameData;

  @override
  ListenableState<EntityState<StatisticsList>> get statisticsData =>
      _statisticsData;

  @override
  ListenableState<EntityState<TrainingInfo>> get workoutData => _workoutData;

  @override
  ListenableState<EntityState<bool>> get achievementsButtonIsLoading =>
      _achievementsButtonIsLoading;

  @override
  ListenableState<EntityState<int>> get currentSet => _currentSet;

  @override
  ListenableState<EntityState<int>> get currentGame => _currentGame;

  late EntityStateNotifier<Information> _informationData;
  late EntityStateNotifier<GameData> _gameData;
  late EntityStateNotifier<StatisticsList> _statisticsData;
  late EntityStateNotifier<TrainingInfo> _workoutData;
  late EntityStateNotifier<int> _index;
  late EntityStateNotifier<num> _currentLevel;
  late EntityStateNotifier<String> _currentComplexity;
  late EntityStateNotifier<int> _currentSet;
  late EntityStateNotifier<int> _currentGame;
  late EntityStateNotifier<UserInfo> _userInfo;
  late EntityStateNotifier<bool> _achievementsButtonIsLoading;
  late List<Achievement> _allAchievementsData = [];
  late List<FlSpot> _spots = [];
  late List<Game> _gameListData = [];

  /// Конструктор
  ProfilePageWidgetModel(
    ProfilePageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  @override
  Future<void> onInformation() async {
    _index.content(0);
    _informationData.loading();
    try {
      final res = await model.getInformationData();
      _informationData.content(res);
    } on FormatException catch (e) {
      _informationData.error(e);
    }
  }

  @override
  Future<void> onGame() async {
    _index.content(1);
    _gameData.loading();
    final res = await model.getGameData();
    _gameData.content(res);
    _userNotifier
      ..currentLevel = res.currentLevel
      ..currentComplexity = res.levels[res.currentLevel.toInt()].complexity;
    _currentLevel.content(_userNotifier.currentLevel);
    _currentComplexity.content(_userNotifier.currentComplexity);
  }

  @override
  Future<void> onStatistics() async {
    _index.content(2);
    _statisticsData.loading();
    try {
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
    } on FormatException catch (e) {
      _statisticsData.error(e);
    }
  }

  @override
  Future<void> toAchievementsPage() async {
    _achievementsButtonIsLoading.content(true);
    _allAchievementsData = [];
    final res = await model.getAchievementsData();
    _allAchievementsData = res;

    //ignore:use_build_context_synchronously
    coordinator.navigate(
      context,
      AppCoordinate.achievementsPage,
      arguments: _allAchievementsData,
    );
    _achievementsButtonIsLoading.content(false);
  }

  @override
  Future<void> toSettingsPage() async {
    coordinator.navigate(
      context,
      AppCoordinate.settingsPage,
      arguments: _userInfo.value?.data,
    );
  }

  @override
  Future<void> onWorkoutInformation(int date) async {
    _index.content(3);

    _workoutData.loading();
    try {
      final res = await model.getTrainingData();
      _workoutData.content(res);
      _gameListData = workoutData.value?.data?.sets[0].game ?? [];
    } on FormatException catch (e) {
      _workoutData.error(e);
    }
  }

  /// изменение уровня сложности
  @override
  void changeCurrentLevel(num level) {
    if (_userNotifier.currentLevel != level) {
      _userNotifier.currentLevel = level;
      _currentLevel.content(_userNotifier.currentLevel);
      _currentComplexity.content(
        _gameData.value?.data?.levels[level.toInt()].complexity ?? 'Light',
      );
      _userNotifier.currentComplexity =
          _gameData.value?.data?.levels[level.toInt()].complexity ?? 'Light';
    }
  }

  /// изменение уровня сложности
  @override
  void changeCurrentComplexity(String complexity) {
    if (_userNotifier.currentComplexity != complexity) {
      _userNotifier.currentComplexity = complexity;
      _currentComplexity.content(_userNotifier.currentComplexity);
    }
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
    if (date < 10 && _statisticsData.value?.data?.efficiencyList.length != 1) {
      checkData =
          _statisticsData.value?.data?.efficiencyList[date].date.toInt() ?? 0;
    }
    if (_statisticsData.value?.data?.efficiencyList.length == 1) {
      checkData =
          _statisticsData.value?.data?.efficiencyList[0].date.toInt() ?? 0;
    }
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

  /// Всплывающее окно с уведомлением о новом достижении
  void achievementsDialog() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog<void>(
        barrierDismissible: false,
        builder: (context) {
          return AchievementsDialog(
            width: width,
            back: () => Navigator.maybePop(context),
            isInfo: false,
            achievements: [
              Achievement(
                name: 'Smash power',
                url:
                    'lib/features/pages/profile_page/assets/images/achivment_test.png',
                isGetting: false,
                date: '',
              ),
              Achievement(
                name: 'Заряженный',
                url:
                    'lib/features/pages/profile_page/assets/images/achivment_test.png',
                isGetting: false,
                date: '',
              ),
            ],
          );
        },
        context: context,
      );
    });
  }

  Future<void> _initLoad() async {
    _index = EntityStateNotifier<int>();

    _userInfo = EntityStateNotifier<UserInfo>();
    _userInfo.loading();
    _achievementsButtonIsLoading = EntityStateNotifier<bool>();
    _achievementsButtonIsLoading.content(false);
    final data = await model.getUserInfo();
    _userInfo.content(data);

    _currentLevel = EntityStateNotifier<num>();
    _currentComplexity = EntityStateNotifier<String>();

    _currentSet = EntityStateNotifier<int>();
    _currentSet.content(0);
    _currentGame = EntityStateNotifier<int>();
    _currentGame.content(0);

    _informationData = EntityStateNotifier<Information>();
    _gameData = EntityStateNotifier<GameData>();
    _statisticsData = EntityStateNotifier<StatisticsList>();
    _workoutData = EntityStateNotifier<TrainingInfo>();

    await onInformation();

    if (newAchievements) {
      achievementsDialog();
    }
    // 2446619419
  }
}
