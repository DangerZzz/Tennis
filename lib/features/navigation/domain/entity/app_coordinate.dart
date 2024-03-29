import 'package:soft_weather_tennis/features/navigation/domain/entity/coordinate.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/statistics_in_game_widget.dart';
import 'package:soft_weather_tennis/features/pages/main_page/main_screen_widget.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/pages/achievements_page.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/characteristics_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page/name_edit_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/pages/useful_full_info_page/useful_full_info_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_widget.dart';
import 'package:soft_weather_tennis/features/temp/screens/temp_screen/temp_screen.dart';

/// A set of routes for the entire app.
class AppCoordinate implements Coordinate {
  /// Initialization screens.
  static final initScreen = AppCoordinate._('auth');

  /// Initialization screens([TempScreen]).
  static final temp = AppCoordinate._('temp');

  /// Initialization screens([AuthorizationPageWidget]).
  static final authScreen = AppCoordinate._('auth');

  /// Initialization screens([MainScreenWidget]).
  static final mainScreen = AppCoordinate._('main');

  /// Initialization screens([BestPageWidget]).
  static final bestPage = AppCoordinate._('best', inner: true);

  /// Initialization screens([GamePageWidget]).
  static final gamePage = AppCoordinate._('game', inner: true);

  /// Initialization screens([ProfilePageWidget]).
  static final profilePage = AppCoordinate._('profile', inner: true);

  /// Initialization screens([RatingPageWidget]).
  static final ratingPage = AppCoordinate._('rating', inner: true);

  /// Initialization screens([UsefulPageWidget]).
  static final usefulPage = AppCoordinate._('useful', inner: true);

  /// Initialization screens([UsefulPageWidget]).
  static final achievementsPage = AppCoordinate._('achievements');

  /// Initialization screens([SettingsPageWidget]).
  static final settingsPage = AppCoordinate._('settings');

  /// Initialization screens([AvatarPageWidget]).
  static final avatarPage = AppCoordinate._('avatar');

  /// Initialization screens([CharacteristicsPageWidget]).
  static final characteristicsPage = AppCoordinate._('characteristics');

  /// Initialization screens([NameEditPageWidget]).
  static final nameEditPage = AppCoordinate._('nameEditPage');

  /// Initialization screens([UsefulFullInfoPageWidget]).
  static final usefulFullInfoPage = AppCoordinate._('usefulDescription');

  /// Initialization screens([ProPlayerInfoPageWidget]).
  static final proPlayerInfoPage = AppCoordinate._('proPlayerInfo');

  /// Initialization screens([StatisticsInGameWidget]).
  static final statisticInGamePage = AppCoordinate._('statisticInGame');

  /// Initialization screens([NewGamePageWidget]).
  static final newGamePage = AppCoordinate._('newGame');

  // TODO(daniil): add new page here

  /// Initialization screens(it can be any screens).
  static final initial = initScreen;

  final String _value;

  final bool _inner;

  @override
  bool get isInner => _inner;

  @override
  String get name => _value;

  AppCoordinate._(this._value, {bool inner = false}) : _inner = inner;

  @override
  String toString() => _value;
}

/// List of main routes of the app.
final Map<AppCoordinate, CoordinateBuilder> appCoordinates = {
  AppCoordinate.initial: (_, __) => const AuthorizationPageWidget(),
  AppCoordinate.initScreen: (_, __) => const AuthorizationPageWidget(),
  AppCoordinate.temp: (_, __) => const TempScreen(),
  AppCoordinate.authScreen: (_, __) => const AuthorizationPageWidget(),
  AppCoordinate.mainScreen: (_, __) => MainScreenWidget(),
  AppCoordinate.usefulPage: (_, __) => const UsefulPageWidget(),
  AppCoordinate.ratingPage: (_, __) => const RatingPageWidget(),
  AppCoordinate.profilePage: (_, __) => const ProfilePageWidget(),
  AppCoordinate.gamePage: (_, __) => const GamePageWidget(),
  AppCoordinate.bestPage: (_, __) => const BestPageWidget(),
  AppCoordinate.achievementsPage: (_, __) => const AchievementsPage(),
  AppCoordinate.settingsPage: (_, __) => const SettingsPageWidget(),
  AppCoordinate.avatarPage: (_, __) => const AvatarPageWidget(),
  AppCoordinate.characteristicsPage: (_, __) =>
      const CharacteristicsPageWidget(),
  AppCoordinate.nameEditPage: (_, __) => const NameEditPageWidget(),
  AppCoordinate.usefulFullInfoPage: (_, __) => const UsefulFullInfoPageWidget(),
  AppCoordinate.proPlayerInfoPage: (_, __) => const ProPlayerInfoPageWidget(),
  AppCoordinate.statisticInGamePage: (_, __) => const StatisticsInGameWidget(),
  AppCoordinate.newGamePage: (_, __) => const NewGamePageWidget(),
};
