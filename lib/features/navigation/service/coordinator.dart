import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/coordinate.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_widget.dart';

/// Class that coordinates navigation for the whole app and provides
/// methods for navigation.
class Coordinator extends ChangeNotifier {
  final _coordinates = <Coordinate, _Route>{};

  final _pages = [
    // MaterialPage<void>(
    //   key: const ValueKey('/main'),
    //   name: 'main',
    //   child: MainScreenWidget(),
    // ),
    // const MaterialPage<void>(
    //   key: ValueKey('/temp'),
    //   name: 'temp',
    //   child: TempScreen(),
    // ),
    //
    // const MaterialPage<void>(
    //   key: ValueKey('/best'),
    //   name: 'best',
    //   child: BestPageWidget(),
    // ),
    // const MaterialPage<void>(
    //   key: ValueKey('/game'),
    //   name: 'game',
    //   child: GamePageWidget(),
    // ),
    // const MaterialPage<void>(
    //   key: ValueKey('/profile'),
    //   name: 'profile',
    //   child: ProfilePageWidget(),
    // ),
    // const MaterialPage<void>(
    //   key: ValueKey('/rating'),
    //   name: 'rating',
    //   child: RatingPageWidget(),
    // ),
    // const MaterialPage<void>(
    //   key: ValueKey('/useful'),
    //   name: 'useful',
    //   child: UsefulPageWidget(),
    // ),

    /// Не менять, должно быть последним
    const MaterialPage<void>(
      key: ValueKey('/auth'),
      name: 'auth',
      child: AuthorizationPageWidget(),
    ),
  ];

  /// Initial screens coordinates.
  Coordinate? initialCoordinate;

  /// Coordinate list.
  Map<Coordinate, _Route> get coordinates => _coordinates;

  /// [Page]s list.
  List<Page> get pages => List.of(_pages);

  /// Initial screens route.
  String? get initialRoute => _coordinates[initialCoordinate]?.path;

  /// Конструктор [Coordinator]
  Coordinator({bool codeBioLogin = false}) {
    if (codeBioLogin) {
      _pages.add(
        const MaterialPage<void>(
          key: ValueKey('/auth'),
          name: 'auth',
          child: AuthorizationPageWidget(),
        ),
      );
    }
  }

  /// Method for registering new coordinate.
  void registerCoordinates(
    String name,
    Map<Coordinate, CoordinateBuilder> coordinates,
  ) {
    _coordinates.addEntries(
      coordinates.entries.map(
        (entry) => MapEntry(
          entry.key,
          _Route('$name${entry.key}', entry.value),
        ),
      ),
    );
  }

  /// Main method for navigation.
  void navigate(
    BuildContext context,
    Coordinate target, {
    Object? arguments,
    bool replaceCurrentCoordinate = false,
    bool replaceRootCoordinate = false,
    bool ignoreInner = false,
  }) {
    if (!ignoreInner &&
        target.isInner &&
        pages.last.name == '${target.name}_inner') return;
    final path = _coordinates[target]?.path;

    if (replaceRootCoordinate) {
      _pages.clear();
    } else if (replaceCurrentCoordinate) {
      _pages.removeLast();
    }
    if (!ignoreInner && target.isInner) {
      if (_pages.any((element) => element.name == '${target.name}_inner')) {
        _pages.removeWhere((element) => element.name == '${target.name}_inner');
      }
    }

    _pages.add(_buildMaterialPage(context, target, arguments, path));

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  /// Method for removing the topmost route.
  void pop() {
    assert(_pages.isNotEmpty);

    _pages.removeLast();

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  /// Method for deleting all routes except the first.
  void popUntilRoot() {
    assert(_pages.isNotEmpty);

    _pages.removeRange(1, _pages.length);

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  /// Method for deleting all routes except the first and inserting a new
  /// route in their place.
  void replaceUntilRoot(
    BuildContext context,
    Coordinate target, {
    Object? arguments,
  }) {
    assert(_pages.isNotEmpty);
    final path = _coordinates[target]?.path;

    _pages
      ..removeRange(1, _pages.length)
      ..add(_buildMaterialPage(context, target, arguments, path));

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  MaterialPage<void> _buildMaterialPage(
    BuildContext context,
    Coordinate coordinate,
    Object? arguments,
    String? path, {
    bool ignoreInner = false,
  }) {
    final body = _coordinates[coordinate]!.builder.call(
          context,
          arguments,
        );
    var name = path ?? '';
    if (!ignoreInner && coordinate.isInner) {
      name += '_inner';
    }
    name = name.replaceAll('/', '');
    return MaterialPage<void>(
      key: ValueKey(path),
      name: name,
      child: Scaffold(
        body: body,
      ),
      arguments: arguments,
    );
  }
}

class _Route {
  final String path;
  final CoordinateBuilder builder;

  const _Route(this.path, this.builder);
}
