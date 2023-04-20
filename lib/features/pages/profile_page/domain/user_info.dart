///Сущность достижения
class UserInfo {
  /// ссылка на фоновое изображение
  final String backgroundImageUrl;

  /// ссылка на изображение аватара
  final String avatarUrl;

  /// Имя
  final String name;

  /// Фамилия
  final String surname;

  /// звание
  final String rank;

  /// Очки
  final String? points;

  /// Очки
  final num? currentLevel;

  /// Очки
  final num? nextLevel;

  ///конструктор [UserInfo]
  UserInfo({
    required this.name,
    required this.surname,
    required this.avatarUrl,
    required this.backgroundImageUrl,
    required this.points,
    required this.rank,
    required this.currentLevel,
    required this.nextLevel,
  });
}
