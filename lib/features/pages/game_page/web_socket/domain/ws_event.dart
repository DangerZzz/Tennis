// ignore_for_file: avoid_positional_boolean_parameters

/// Тип события из веб-сокета
enum WsEventType {
  /// Событие обновления
  update,

  /// Событие завершения
  completed,

  /// Событие подключения тренера
  connect,

  /// Событие получения токена
  connectToken,

  /// Событие начала
  start,

  /// Событие токена начала
  startToken,

  /// Событие приостановки
  togglePause,

  /// Событие отмены
  cancel,
}

/// Событие из WS. передается в стримах
class WsEvent {
  /// Тип события
  final WsEventType? type;

  /// Данные в событии (обновленный лот etc.)
  final dynamic data;

  /// Конструктор
  WsEvent(
    this.type,
    this.data,
  );
}
