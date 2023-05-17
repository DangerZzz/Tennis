///Сущность списка рейтинка
class RatingList {
  /// Список данных рейтинга игроков
  final List<Rating> ratingData;

  ///конструктор [RatingList]
  RatingList({
    required this.ratingData,
  });
}

///Сущность рейтинка игроков
class Rating {
  /// ссылка на изображение
  final String avatarUrl;

  /// Имя игрока
  final String name;

  /// Количество очков
  final String points;

  /// Позиция в рейтинге
  final int position;

  /// Флаг "пользователь ли это"
  final bool isUser;

  ///конструктор [Rating]
  Rating({
    required this.avatarUrl,
    required this.name,
    required this.points,
    required this.isUser,
    required this.position,
  });
}
