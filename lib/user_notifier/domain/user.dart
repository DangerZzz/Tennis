import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';

/// Сущность, описывающий основные бизнес поля пользователя
class User {
  /// Имя пользователя
  final String name;

  /// Имя пользователя
  final String surname;

  /// Телефон пользователя
  final String phone;

  /// Телефон пользователя
  final String avatarImageUrl;

  /// Телефон пользователя
  final String backgroundImageUrl;

  /// Телефон пользователя
  final bool isTrainer;

  /// Телефон пользователя
  final CharactersInfo? charactersInfo;

  /// Конструктор [User]
  User({
    required this.name,
    required this.surname,
    required this.avatarImageUrl,
    required this.charactersInfo,
    required this.backgroundImageUrl,
    required this.phone,
    required this.isTrainer,
  });
}
