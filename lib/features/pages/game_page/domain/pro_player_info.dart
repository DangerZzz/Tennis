///Сущность подробных данных про игрока
class ProPlayerInfoData {
  /// Имя игрока
  final String name;

  /// Описание
  final String description;

  /// Описание
  final String imageUrl;

  /// Рейтинг по первому показателю
  final num rating1;

  /// Рейтинг по первому показателю
  final num rating2;

  /// Рейтинг по первому показателю
  final num rating3;

  /// Рейтинг по первому показателю
  final num rating4;

  ///конструктор [ProPlayerInfoData]
  ProPlayerInfoData({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rating1,
    required this.rating2,
    required this.rating3,
    required this.rating4,
  });
}
