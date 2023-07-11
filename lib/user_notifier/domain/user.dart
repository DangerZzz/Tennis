/// Сущность, описывающий основные бизнес поля пользователя
class User {
  /// Имя пользователя
  final String name;

  /// Имя пользователя
  final String surname;

  /// Телефон пользователя
  final String phone;

  /// Телефон пользователя
  final bool isTrainer;

  /// Конструктор [User]
  User({
    required this.name,
    required this.surname,
    required this.phone,
    required this.isTrainer,
  });
}
