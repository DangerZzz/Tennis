///Сущность страницы "игра"
class GameData {
  /// текст быстрого совета
  final String fastAdvice;

  /// картинка быстрого совета
  final String fastAdviceImageUrl;

  /// Список про игроков
  final List<ProPlayer> proPlayers;

  /// Список тренировок
  final List<Training> trainings;

  ///конструктор [GameData]
  GameData({
    required this.fastAdvice,
    required this.fastAdviceImageUrl,
    required this.proPlayers,
    required this.trainings,
  });
}

///Сущность проф игрока
class ProPlayer {
  ///
  final int id;

  ///
  final int rating;

  /// картинка
  final String imageUrl;

  /// тема
  final String name;

  /// текст
  final String description;

  ///конструктор [ProPlayer]
  ProPlayer({
    required this.id,
    required this.rating,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

///Сущность тренировки/последней игры
class Training {
  ///
  final int id;

  /// название
  final String name;

  /// эффективность
  final String efficiency;

  ///конструктор [Training]
  Training({
    required this.id,
    required this.name,
    required this.efficiency,
  });
}
