import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';

///Сущность страницы информация
class Information {
  /// всего игр
  final num gameCount;

  /// Эффективность
  final num efficiency;

  /// количество трофеев
  final num trophiesCount;

  /// суммарное количество трофеев
  final num trophiesAllCount;

  /// последние трофеи
  final List<Achievement> lastTrophies;

  /// характеристики
  final CharactersInfo charactersInfo;

  /// место в рейтинге
  final num? ratingPosition;

  /// + положения в рейтинге
  final num? ratingChanges;

  ///конструктор [Information]
  Information({
    required this.gameCount,
    required this.efficiency,
    required this.trophiesCount,
    required this.lastTrophies,
    required this.trophiesAllCount,
    required this.charactersInfo,
    required this.ratingPosition,
    required this.ratingChanges,
  });
}
