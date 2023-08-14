import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/preparing_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/di/new_game_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/web_socket/domain/ws_event.dart';
import 'package:soft_weather_tennis/features/pages/game_page/web_socket/domain/ws_event_mapper.dart';
import 'package:soft_weather_tennis/features/pages/game_page/web_socket/dto/ws_message.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';
import 'package:soft_weather_tennis/util/default_error_handler.dart';

///
abstract class INewGamePageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Контролер страницы
  ListenableState<EntityState<String>> get warmUpType;

  /// Контролер страницы
  ListenableState<EntityState<int>> get countdownTime;

  /// текущий сет
  ListenableState<EntityState<int>> get currentSet;

  /// Данные вкладки "тренировка"
  ListenableState<EntityState<TrainingInfo>> get workoutData;

  /// Данные вкладки "тренировка"
  ListenableState<EntityState<UserInfo>> get userData;

  /// Данные подготовки к тренировке
  ListenableState<EntityState<PreparingData>> get preparingData;

  /// Данные подготовки к тренировке
  ListenableState<EntityState<String>> get qrImage;

  /// список игр текущего сета
  List<Game> get gameListData;

  /// текущая гейм
  ListenableState<EntityState<int>> get currentGame;

  ///
  double get width;

  ///
  double get height;

  ///
  String get token;

  ///
  void startGame();

  ///
  void onQrPage();

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
  final userNotifier = appDependencies.userNotifier;
  final model = scope.newGamePageModel;
  // final wsStream = appDependencies.webSockets.filterUpdatesStream;
  return NewGamePageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
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

  ///
  String id = '';

  ///
  final UserNotifier _userNotifier;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  double get height => MediaQuery.of(context).size.height;

  @override
  String get token => _token;

  @override
  ListenableState<EntityState<int>> get currentSet => _currentSet;

  @override
  ListenableState<EntityState<TrainingInfo>> get workoutData => _workoutData;

  @override
  ListenableState<EntityState<UserInfo>> get userData => _userData;

  @override
  ListenableState<EntityState<PreparingData>> get preparingData =>
      _preparingData;

  @override
  ListenableState<EntityState<String>> get qrImage => _qrImage;

  @override
  List<Game> get gameListData => _gameListData;

  @override
  ListenableState<EntityState<int>> get currentGame => _currentGame;

  @override
  ListenableState<EntityState<int>> get index => _index;

  @override
  ListenableState<EntityState<String>> get warmUpType => _warmUpType;

  @override
  ListenableState<EntityState<int>> get countdownTime => _countdownTime;

  late Socket socket;
  late String _token;

  late EntityStateNotifier<int> _index;
  late EntityStateNotifier<String> _warmUpType;
  late EntityStateNotifier<int> _countdownTime;
  late EntityStateNotifier<int> _currentSet;
  late EntityStateNotifier<TrainingInfo> _workoutData;
  late EntityStateNotifier<UserInfo> _userData;
  late EntityStateNotifier<PreparingData> _preparingData;
  late EntityStateNotifier<String> _qrImage;
  late List<Game> _gameListData = [];
  late EntityStateNotifier<int> _currentGame;

  /// Конструктор
  NewGamePageWidgetModel(
    NewGamePageModel model, {
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
  Future<void> dispose() async {
    super.dispose();
    timer.cancel();
  }

  ///Обработчик таймера
  @override
  String countdown(int countdownTime) {
    final min = countdownTime ~/ 60;
    final sec = countdownTime % 60;
    '$sec'.padLeft(2, '0');
    return '$min:${sec < 10 ? '0' : ''}$sec';
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

  ///Возврат назад по индексу( возможно не нужен)
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

  ///Выход
  @override
  Future<void> onBack() async {
    coordinator.pop();
  }

  ///Вторая страница, которую видит пользователь
  @override
  Future<void> onQrPage() async {
    _index.content(1);
    final res = await model.getQRData(id: id);
    _qrImage.content(res);
  }

  ///Вызывается по сокету, начинает игру, вызывает страницу заминки
  @override
  Future<void> startGame() async {
    try {
      _token = '${await _userNotifier.getTokens()}connect_game=$_token';
      await model.gameStart(token: _token);
      await toHitch();
    } on FormatException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Подключение к сокетам
  void webSocketConnection(String id) {
    final token = _userNotifier.tokenStorage.getAccessToken();
    try {
      socket = io('wss://tennis.trackercracker.ru:0', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {'Authorization': '${token?.split('token=')[1]}'},
      });
      socket
        ..connect()
        ..emit('room-join', <String, dynamic>{'room': 'game:$id'})
        ..onConnectError((dynamic error) {
          DefaultErrorHandler().handleError('$error');
        })
        ..on('game-action', _onChangeGameStatus)
        ..on('gameAction-action', _onAuctionChanges)
        ..on('gameItem-action', _onAuctionChanges)
        ..on('gameSection-action', _onAuctionChanges);
      // ..on('pong', _onAuctionChanges);
    } on FormatException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Первая страница, подготовка к игре
  Future<void> trainingPreparation() async {
    try {
      final currentLevel = ModalRoute.of(context)?.settings.arguments as List;
      final userInfo = await model.getUserInfo();
      _userData.content(userInfo);
      id = await model.getInitialData(
        level: currentLevel[0] as num,
        complexity: currentLevel[1] as String,
      );
      webSocketConnection(id);
      final res = await model.getPreparingData(id: id);
      _preparingData.content(res);
      _index.content(0);
    } on FormatException catch (e) {
      _preparingData.error(e);
    }
  }

  /// Запуск таймера
  Future<void> startTimer() async {
    _countdownTime.content(180);
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
    if ((_warmUpType.value?.data ?? '') == 'Бег по кругу') {
      _warmUpType.content('Упражнения для суставов');
      await toHitch();
    }
    if ((_warmUpType.value?.data ?? '') == 'Упражнения для суставов') {
      _warmUpType.content('Упражнения для мышц');
      await toHitch();
    }

    if ((_warmUpType.value?.data ?? '') == 'Упражнения для мышц') {
      _warmUpType.content('Ожидание начала игры');
      _countdownTime.content(60);
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
      _index.content(4);
    }
  }

  /// Запуск таймеров на странице "Разминка"
  Future<void> toHitch() async {
    if ((_warmUpType.value?.data ?? '') == 'Бег по кругу') {
      _index.content(3);
      await startTimer();
    }

    if ((_warmUpType.value?.data ?? '') == 'Упражнения для суставов') {
      await startTimer();
    }

    if ((_warmUpType.value?.data ?? '') == 'Упражнения для мышц') {
      await startTimer();
    }
  }

  Future<void> _initLoad() async {
    _index = EntityStateNotifier<int>();
    _index.content(0);
    _warmUpType = EntityStateNotifier<String>();
    _warmUpType.content('Бег по кругу');
    _currentSet = EntityStateNotifier<int>();
    _currentSet.content(0);
    _workoutData = EntityStateNotifier<TrainingInfo>();
    _workoutData.loading();
    _userData = EntityStateNotifier<UserInfo>();
    _userData.loading();
    _preparingData = EntityStateNotifier<PreparingData>();
    _preparingData.loading();
    _qrImage = EntityStateNotifier<String>();
    _preparingData.loading();
    _currentGame = EntityStateNotifier<int>();
    _currentGame.content(0);
    _countdownTime = EntityStateNotifier<int>();
    await trainingPreparation();
  }

  void _onAuctionChanges(dynamic data) {
    if (data is! Map<String, dynamic>) return;
  }

  void _onChangeGameStatus(dynamic data) {
    if (data is! Map<String, dynamic>) return;
    final event = wsEventMapper(WsMessageDto.fromJson(data));
    if (event.type == WsEventType.connect) {
      if (_index.value?.data != 2) {
        _index.content(2);
      }
    }
    if (event.type == WsEventType.connect) {
      if (_index.value?.data != 2) {
        _index.content(2);
      }
    }
    if (event.type == WsEventType.connectToken) {
      final res = data['data'] as Map<String, dynamic>;
      _token = res['token'] as String;
    }
  }
}
