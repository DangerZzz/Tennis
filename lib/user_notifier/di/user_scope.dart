/// Интерфейс пользователя
abstract class IUserNotifier {
  ///id пользователя
  String get id;

  // ///email пользователя
  // String get email;

  ///имя пользователя
  String get name;

  ///имя пользователя
  String get surname;

  /// Залогинен ли пользователь
  bool get isLogin;

  /// Номер телефона
  String get phone;

  /// Флаг, показывающий роль пользователя
  bool get isTrainer;

  /// Возможность использовать биометрию
  bool get canUseBiometric;

  /// Возможность использовать биометрию
  bool get canUseFaceID;

  /// Возможность использовать биометрию
  bool get canUseFingerprint;

  /// Подзрузка данных пользователя + обновление
  Future<void> updateUser(
    bool isTrainer,
    String id,
    String name,
    String surname,
    String phone,
  ); // TODO(daniil): исправить

  // /// Очистка данных пользователя - logout
  // Future<void> removeUser();

  // /// Метод, проставляющий токены авторизации из хранилища в dio
  // Future<void> updateDio();

  // /// Установка токена в хранилище
  // Future<void> setTokens({
  //   required String accessToken,
  //   required String refreshToken,
  // });
  //
  // ///
  // Future<void> setTokensFromHeaders();
  //
  // /// Установка токена в хранилище и в хэдеры dio
  // Future<void> setTokensAndDio({
  //   required String accessToken,
  //   required String refreshToken,
  // });
  //
  // /// Сохранение токенов на устройство
  // Future<void> saveTokens();
  //
  // /// восстановление токенов
  // Future<void> loadTokens();

  /// Сохранение кода в биометрическое хранилище
  Future<void> updateBiometricStorage();

  /// Сохранение кода в биометрическое хранилище
  Future<void> authorizeBiometrics();
}
