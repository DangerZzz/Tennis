import 'package:soft_weather_tennis/features/pages/game_page/web_socket/domain/ws_event.dart';
import 'package:soft_weather_tennis/features/pages/game_page/web_socket/dto/ws_message.dart';

/// Заполнение модели [WsEvent] данными [WsMessageDto]
WsEvent wsEventMapper(WsMessageDto message) {
  late WsEventType? type;

  switch (message.action) {
    case 'start':
      type = WsEventType.start;
      break;
    case 'cancel':
      type = WsEventType.cancel;
      break;
    case 'update':
      type = WsEventType.update;
      break;
    case 'completed':
      type = WsEventType.completed;
      break;
    case 'connect':
      type = WsEventType.connect;
      break;
    case 'startToken':
      type = WsEventType.startToken;
      break;

    case 'connectToken':
      type = WsEventType.connectToken;
      break;
    case 'togglePause':
      type = WsEventType.togglePause;
      break;
    default:
      type = null;
  }

  return WsEvent(
    type,
    message.data,
  );
}
