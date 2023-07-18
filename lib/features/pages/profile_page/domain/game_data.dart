///Сущность игры
class GameData {
  /// текущий уровень
  final num maxLevel;

  /// сложность
  final String maxComplexity;

  ///конструктор [GameData]
  GameData({
    required this.maxComplexity,
    required this.maxLevel,
  });
}
