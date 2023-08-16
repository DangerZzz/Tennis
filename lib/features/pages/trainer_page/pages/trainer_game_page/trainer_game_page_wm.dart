import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/web_socket/domain/ws_event.dart';
import 'package:soft_weather_tennis/features/pages/game_page/web_socket/domain/ws_event_mapper.dart';
import 'package:soft_weather_tennis/features/pages/game_page/web_socket/dto/ws_message.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/domain/game_mapper.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/dto/game_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/di/trainer_game_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/trainer_game_page_model.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/pages/trainer_game_page/trainer_game_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';
import 'package:soft_weather_tennis/util/default_error_handler.dart';

///
abstract class ITrainerGamePageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Контролер страницы
  ListenableState<EntityState<int>> get countdownTime;

  /// Контролер страницы
  ListenableState<EntityState<String>> get warmUpType;

  ///
  double get width;

  ///
  double get height;

  ///
  String countdown(int countdownTime);
}

///
TrainerGamePageWidgetModel defaultTrainerGamePageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<ITrainerGamePageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.trainerGamePageModel;
  final userNotifier = appDependencies.userNotifier;
  return TrainerGamePageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for TrainerGamePageWidget
class TrainerGamePageWidgetModel
    extends WidgetModel<TrainerGamePageWidget, TrainerGamePageModel>
    implements ITrainerGamePageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  ///
  final timer = Timer(Duration.zero, () {});

  ///
  final UserNotifier _userNotifier;

  ///
  late Socket socket;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  double get height => MediaQuery.of(context).size.height;

  @override
  ListenableState<EntityState<int>> get index => _index;

  @override
  ListenableState<EntityState<int>> get countdownTime => _countdownTime;

  @override
  ListenableState<EntityState<String>> get warmUpType => _warmUpType;

  late EntityStateNotifier<int> _index;
  late EntityStateNotifier<int> _countdownTime;
  late EntityStateNotifier<String> _warmUpType;

  ///Конструктор
  TrainerGamePageWidgetModel(
    TrainerGamePageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  ///Обработчик таймера
  @override
  String countdown(int countdownTime) {
    final min = countdownTime ~/ 60;
    final sec = countdownTime % 60;
    '$sec'.padLeft(2, '0');
    return '$min:${sec < 10 ? '0' : ''}$sec';
  }

  ///
  Future<void> sendQrData() async {
    try {
      final qrData =
          (ModalRoute.of(context)?.settings.arguments ?? '') as String;
      final id = await model.sendQrData(connect: qrData);
      webSocketConnection(id);
    } on FormatException catch (e) {
      debugPrint(e.toString());
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
      _index.content(2);
    }
  }

  /// Запуск таймеров на странице "Разминка"
  Future<void> toHitch() async {
    if ((_warmUpType.value?.data ?? '') == 'Бег по кругу') {
      _index.content(1);
      await startTimer();
    }

    if ((_warmUpType.value?.data ?? '') == 'Упражнения для суставов') {
      await startTimer();
    }

    if ((_warmUpType.value?.data ?? '') == 'Упражнения для мышц') {
      await startTimer();
    }
  }

  ///
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
        ..on('game-action', _onChangeGameStatus);
      // ..on('gameAction-action', _onAuctionChanges)
      // ..on('gameItem-action', _onAuctionChanges)
      // ..on('gameSection-action', _onAuctionChanges);
    } on FormatException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onChangeGameStatus(dynamic data) {
    if (data is! Map<String, dynamic>) return;
    final event = wsEventMapper(WsMessageDto.fromJson(data));
    if (event.type == WsEventType.start) {
      final res = GameStartDataDtO.fromJson(event.data as Map<String, dynamic>);
      final data = gameDataMapper(res);
      toHitch();
    }
  }

  Future<void> _initLoad() async {
    _index = EntityStateNotifier<int>();
    _index.content(0);
    _countdownTime = EntityStateNotifier<int>();
    _warmUpType = EntityStateNotifier<String>();
    _warmUpType.content('Бег по кругу');
    await sendQrData();
  }
}
