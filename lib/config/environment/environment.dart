import 'package:flutter/foundation.dart';
import 'package:soft_weather_tennis/config/environment/build_types.dart';

/// Environment configuration.
class Environment<T> implements Listenable {
  static Environment? _instance;
  final BuildType _currentBuildType;

  final bool _useMock;

  final _appTokens = const String.fromEnvironment('APP_TOKEN');
  final _signatures = const String.fromEnvironment('SIGNATURE');

  /// Configuration.
  T get config => _config.value;

  set config(T c) => _config.value = c;

  /// Is this application running in debug mode.
  bool get isDebug => _currentBuildType == BuildType.debug;

  /// Is this application running in release mode.
  bool get isRelease => _currentBuildType == BuildType.release;

  /// Use mock repository
  bool get useMock => _useMock;

  /// Токен приложения
  String get appTokens => _appTokens;

  /// Сигнатура
  String get signatures => _signatures;

  /// App build type.
  BuildType get buildType => _currentBuildType;

  ValueNotifier<T> _config;

  Environment._(this._currentBuildType, T config, this._useMock)
      : _config = ValueNotifier(config);

  /// Provides instance [Environment].
  factory Environment.instance() => _instance as Environment<T>;

  @override
  void addListener(VoidCallback listener) {
    _config.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _config.removeListener(listener);
  }

  /// Initializing the environment.
  static void init<T>({
    required BuildType buildType,
    required T config,
    bool useMock = false,
  }) {
    _instance ??= Environment<T>._(buildType, config, useMock);
  }
}
