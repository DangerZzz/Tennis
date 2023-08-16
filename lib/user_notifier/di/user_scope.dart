/// Интерфейс пользователя
abstract class IUserNotifier {
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
    String name,
    String surname,
    String phone,
  ); // TODO(daniil): исправить

  // /// Очистка данных пользователя - logout
  // Future<void> removeUser();

  // /// Метод, проставляющий токены авторизации из хранилища в dio
  // Future<void> updateDio();

  ///Сохранение всех токенов в хранилище
  Future<void> saveTokens(String code);

  ///Загрузка всех токенов
  Future<void> loadTokens(String code);

  ///Установка куки токена
  Future<void> setCookieToken();

  ///Установка аксес токена
  Future<void> setAccessToken(String access);

  ///Установка рефреш токена
  Future<void> setRefreshToken(String refresh);

  ///Функция получения токенов для записи их в куки
  Future<String> getTokens();

  /// Сохранение кода в биометрическое хранилище
  Future<void> updateBiometricStorage(bool init);

  /// Сохранение кода в биометрическое хранилище
  Future<void> authorizeBiometrics();
}
