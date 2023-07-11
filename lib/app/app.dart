import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
// import 'package:soft_weather_tennis/config/app_config.dart';
// import 'package:soft_weather_tennis/config/debug_options.dart';
// import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/common/widgets/di_scope/di_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/delegate/app_router_delegate.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/domain/parser/app_route_information_parses.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/di/authorizarion_scope.dart';
import 'package:soft_weather_tennis/features/pages/best_page/di/best_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/di/game_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/di/new_game_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/di/pro_player_info_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/di/statistics_in_game_scope.dart';
import 'package:soft_weather_tennis/features/pages/main_page/di/main_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/di/profile_scope.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/di/rating_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/di/settings_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/di/avatar_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/di/characteristics_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page/di/name_edit_page_scope.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/di/useful_scope.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/pages/useful_full_info_page/di/useful_scope.dart';
import 'package:soft_weather_tennis/generated/l10n.dart';

/// App widget.
class App extends StatefulWidget {
  /// Create an instance App.
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;

  @override
  void initState() {
    super.initState();

    _scope = AppScope(applicationRebuilder: _rebuildApplication);

    _setupRouting(_scope.coordinator);
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      key: ObjectKey(_scope),
      factory: () {
        return _scope;
      },
      child: MultiDiScope(
        scopes: [
          MultiDiScopeItem<IAuthorizationPageScope>(
            factory: () {
              return AuthorizationPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IMainPageScope>(
            factory: () {
              return MainPageScope(
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IBestPageScope>(
            factory: () {
              return BestPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IGamePageScope>(
            factory: () {
              return GamePageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IProfilePageScope>(
            factory: () {
              return ProfilePageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IRatingPageScope>(
            factory: () {
              return RatingPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IUsefulPageScope>(
            factory: () {
              return UsefulPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IUsefulFullInfoPageScope>(
            factory: () {
              return UsefulFullInfoPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<ISettingsPageScope>(
            factory: () {
              return SettingsPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),

          MultiDiScopeItem<IAvatarPageScope>(
            factory: () {
              return AvatarPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<ICharacteristicsPageScope>(
            factory: () {
              return CharacteristicsPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<INameEditPageScope>(
            factory: () {
              return NameEditPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IProPlayerInfoPageScope>(
            factory: () {
              return ProPlayerInfoPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),

          MultiDiScopeItem<IStatisticsInGameScope>(
            factory: () {
              return StatisticsInGameScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),

          MultiDiScopeItem<INewGamePageScope>(
            factory: () {
              return NewGamePageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),

          // TODO(daniil): add new page here
        ],
        child: MaterialApp.router(
          /// Localization.
          locale: _localizations.first,
          localizationsDelegates: _localizationsDelegates,
          supportedLocales: _localizations,

          /// This is for navigation.
          routeInformationParser: AppRouteInformationParser(),
          routerDelegate: AppRouterDelegate(_scope.coordinator),
        ),
      ),
    );
  }

  // DebugOptions _getDebugConfig() {
  //   return Environment<AppConfig>.instance().config.debugOptions;
  // }

  void _setupRouting(Coordinator coordinator) {
    coordinator
      ..initialCoordinate = AppCoordinate.initScreen
      ..registerCoordinates('/', appCoordinates);
  }

  void _rebuildApplication() {
    setState(() {
      _scope = AppScope(applicationRebuilder: _rebuildApplication);
      _setupRouting(_scope.coordinator);
    });
  }
}

const _localizations = [Locale('ru', 'RU')];

const _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  AppLocalizations.delegate,
];
