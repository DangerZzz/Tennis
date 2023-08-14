import 'package:soft_weather_tennis/config/debug_options.dart';

/// Application configuration.
class AppConfig {
  /// Server url.
  final String url;

  /// WebSocketUrl
  final String wsUrl;

  /// Proxy url.
  final String? proxyUrl;

  /// Additional application settings in debug mode.
  final DebugOptions debugOptions;

  /// Create an instance [AppConfig].
  AppConfig({
    required this.url,
    required this.wsUrl,
    required this.debugOptions,
    this.proxyUrl,
  });

  /// Create an instance [AppConfig] with modified parameters.
  AppConfig copyWith({
    String? url,
    String? wsUrl,
    String? proxyUrl,
    DebugOptions? debugOptions,
  }) =>
      AppConfig(
        url: url ?? this.url,
        wsUrl: wsUrl ?? this.wsUrl,
        proxyUrl: proxyUrl ?? this.proxyUrl,
        debugOptions: debugOptions ?? this.debugOptions,
      );
}
