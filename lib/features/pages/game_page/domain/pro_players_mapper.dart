import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/dto/pro_players_dto.dart';

/// Заполнение модели [ProPlayer] данными [ProPlayersDtO]
ProPlayer proPlayersDataMapper(ProPlayersDtO data) {
  final rating = ((data.ratings?.complexity ?? 0) +
          (data.ratings?.endurance ?? 0) +
          (data.ratings?.impactForce ?? 0) +
          (data.ratings?.tactic ?? 0)) /
      4;
  return ProPlayer(
    id: data.id ?? '',
    name: data.name ?? '',
    description: data.fullDescription ?? '',
    imageUrl: data.avatar?.src ?? '',
    rating: rating.toInt(),
    title: data.description ?? '',
    ratings: Ratings(
      complexity: data.ratings?.complexity ?? 0,
      endurance: data.ratings?.endurance ?? 0,
      impactForce: data.ratings?.impactForce ?? 0,
      tactic: data.ratings?.tactic ?? 0,
    ),
  );
}
