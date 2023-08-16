import 'package:soft_weather_tennis/features/pages/trainer_page/domain/current_game_data.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/dto/game_data_dto.dart';

/// Заполнение модели [CurrentGameData] данными [GameStartDataDtO]
CurrentGameData gameDataMapper(GameStartDataDtO data) {
  final sets = <SectionsData>[];
  for (final set in data.sections ?? <SectionsDataDtO>[]) {
    final games = <ItemsData>[];
    for (var gameIndex = 0; gameIndex < (set.items?.length ?? 0); gameIndex++) {
      final strikes = <ActionsData>[];
      for (final strike
          in set.items![gameIndex].actions ?? <ActionsDataDtO>[]) {
        strikes.add(
          ActionsData(
            type: strike.type ?? '',
            status: strike.status ?? '',
          ),
        );
      }
      games.add(
        ItemsData(
          actions: strikes,
          position: gameIndex + 1,
          status: set.items?[gameIndex].status ?? '',
        ),
      );
    }
    sets.add(
      SectionsData(
        items: games,
        position: set.position ?? 0,
        status: set.status ?? '',
      ),
    );
  }

  return CurrentGameData(
    id: data.id,
    time: data.time ?? 0,
    sections: sets,
    complexity: data.complexity ?? '',
    level: data.level ?? 1,
  );
}
