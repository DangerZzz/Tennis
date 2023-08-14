import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';

/// Server urls.
abstract class Url {
  /// Prod proxy url.
  static String get prodProxyUrl => '';

  /// QA proxy url.
  static String get qaProxyUrl => '192.168.0.1';

  /// Dev proxy url.
  static String get devProxyUrl => '';

  /// Prod ws url.
  static String get prodWsUrl => 'wss://tennis.trackercracker.ru';
  // TODO(daniil): change url

  /// Dev ws url.
  static String get devWsUrl =>
      'wss://tennis.trackercracker.ru'; // TODO(daniil): change url

  /// TRest url.
  static String get testUrl => 'https://tennis.trackercracker.ru';
  // TODO(daniil): change url

  /// Prod url.
  static String get prodUrl => 'https://tennis.trackercracker.ru';
  // TODO(daniil): change url

  /// Dev url.
  static String get devUrl => 'https://tennis.trackercracker.ru';

  /// Base url.
  static String get baseUrl => Environment<AppConfig>.instance().config.url;
}
