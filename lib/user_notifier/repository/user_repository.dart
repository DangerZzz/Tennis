import 'package:soft_weather_tennis/user_notifier/api/client.dart';

/// Репозиторий для сущности пользователя
class UserRepository {
  final UserClient _userClient;

  /// Конструктор [UserRepository]
  UserRepository(this._userClient);

  // /// Разлогин пользователя из системы
  // Future<void> logout() => _userClient.logout();
}
