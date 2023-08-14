import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';

///Сущность страницы "игра"
class GameData {
  /// Список про игроков
  final List<ProPlayer> proPlayers;

  /// Список тренировок
  final List<Statistics> trainings;

  /// Текущий уровень
  final num currentLevel;

  /// текущая сложность
  final String currentComplexity;

  ///конструктор [GameData]
  GameData({
    required this.proPlayers,
    required this.trainings,
    required this.currentComplexity,
    required this.currentLevel,
  });
}

///Сущность проф игрока
class ProPlayer {
  ///
  final String id;

  ///
  final int rating;

  /// картинка
  final String imageUrl;

  /// тема
  final String name;

  /// текст
  final String description;

  /// текст
  final String title;

  /// текст
  final Ratings ratings;

  ///конструктор [ProPlayer]
  ProPlayer({
    required this.id,
    required this.rating,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.title,
    required this.ratings,
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

///Сущность тренировки/последней игры
class Ratings {
  ///Сила удара
  final num impactForce;

  ///Выносливость
  final num endurance;

  ///Тактика
  final num tactic;

  ///Сложность
  final num complexity;

  ///конструктор [Ratings]
  Ratings({
    required this.tactic,
    required this.impactForce,
    required this.endurance,
    required this.complexity,
  });
}
