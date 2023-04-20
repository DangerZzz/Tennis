///Сущность уровня
class LevelData {
  /// уровень
  final num level;

  /// сложность
  final String complexity;

  /// доступность
  final bool isAvailability;

  ///конструктор [LevelData]
  LevelData({
    required this.level,
    required this.complexity,
    required this.isAvailability,
  });
}
