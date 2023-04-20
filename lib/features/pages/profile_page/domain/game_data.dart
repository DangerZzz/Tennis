import 'package:soft_weather_tennis/features/pages/profile_page/domain/level_data.dart';

///Сущность игры
class GameData {
  /// текущий уровень
  final num currentLevel;

  /// сложность
  final List<LevelData> levels;

  ///конструктор [GameData]
  GameData({
    required this.currentLevel,
    required this.levels,
  });
}
