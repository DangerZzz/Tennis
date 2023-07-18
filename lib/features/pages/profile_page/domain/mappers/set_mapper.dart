import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/training_data_dto.dart';

/// Заполнение модели [Sets] данными [SetsDtO]
List<Sets> setDataMapper(TrainingDataDtO data) {
  final sets = <Sets>[];
  for (final set in data.sections ?? <SetsDtO>[]) {
    final games = <Game>[];
    for (var gameIndex = 0; gameIndex < (set.items?.length ?? 0); gameIndex++) {
      final strikes = <PracticedBeats>[];
      for (final strike in set.items![gameIndex].actions ?? <ActionsDtO>[]) {
        strikes.add(
          PracticedBeats(
            name: strike.type ?? '',
            state: strike.status ?? '',
          ),
        );
      }
      games.add(
        Game(
          gameNumber: gameIndex + 1,
          percent: 1,
          practicedBeats: strikes,
        ),
      );
    }
    sets.add(
      Sets(game: games),
    );
  }

  return sets;
}
