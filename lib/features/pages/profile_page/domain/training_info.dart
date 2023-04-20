///Сущность информации о тренировке
class TrainingInfo {
  /// Уровень
  final num level;

  ///Сложность
  final String complexity;

  /// Процент
  final num percent;

  /// Геймы
  final List<Sets> sets;

  ///конструктор [TrainingInfo]
  TrainingInfo({
    required this.complexity,
    required this.level,
    required this.percent,
    required this.sets,
  });
}

///Сущность сета
class Sets {
  /// Геймы
  final List<Game> game;

  ///конструктор [Sets]
  Sets({
    required this.game,
  });
}

///Сущность гейма
class Game {
  /// Уровень
  final num gameNumber;

  /// Процент
  final num percent;

  /// Геймы
  final List<PracticedBeats> practicedBeats;

  ///конструктор [Game]
  Game({
    required this.gameNumber,
    required this.percent,
    required this.practicedBeats,
  });
}

///Сущность отработанных ударов
class PracticedBeats {
  /// Уровень
  final String name;

  /// Процент
  final String state;

  ///конструктор [PracticedBeats]
  PracticedBeats({
    required this.name,
    required this.state,
  });
}
