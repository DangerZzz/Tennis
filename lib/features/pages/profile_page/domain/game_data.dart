///Сущность игры
class GameDataLevels {
  /// текущий уровень
  final num maxLevel;

  /// сложность
  final String maxComplexity;

  ///конструктор [GameDataLevels]
  GameDataLevels({
    required this.maxComplexity,
    required this.maxLevel,
  });
}
