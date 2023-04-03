import 'package:soft_weather_tennis/features/authorization/authorization_page_widget.dart';
import 'package:soft_weather_tennis/features/main_page/main_screen_widget.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/coordinate.dart';
import 'package:soft_weather_tennis/features/temp/screens/temp_screen/temp_screen.dart';

/// A set of routes for the entire app.
class AppCoordinate implements Coordinate {
  /// Initialization screens.
  static final initScreen = AppCoordinate._('temp');

  /// Initialization screens([TempScreen]).
  static final temp = AppCoordinate._('temp');

  /// Initialization screens([AuthorizationPageWidget]).
  static final authScreen = AppCoordinate._('auth');

  /// Initialization screens([MainScreenWidget]).
  static final mainScreen = AppCoordinate._('main');

  /// Initialization screens(it can be any screens).
  static final initial = initScreen;

  final String _value;

  bool _inner;

  AppCoordinate._(this._value, {bool inner = false}) : _inner = inner;

  @override
  String toString() => _value;

  @override
  bool get isInner => _inner;

  @override
  String get name => _value;
}

/// List of main routes of the app.
final Map<AppCoordinate, CoordinateBuilder> appCoordinates = {
  AppCoordinate.initial: (_, __) => const TempScreen(),
  AppCoordinate.temp: (_, __) => const TempScreen(),
  AppCoordinate.authScreen: (_, __) => const AuthorizationPageWidget(),
  AppCoordinate.mainScreen: (_, __) => MainScreenWidget(),
};
