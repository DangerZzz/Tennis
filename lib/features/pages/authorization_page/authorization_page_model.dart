import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/domain/code.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/repository/auth_screen_repository.dart';
import 'package:soft_weather_tennis/util/exception_handler.dart';

/// Default Elementary model for AuthorizationPage module
class AuthorizationPageModel extends ElementaryModel {
  final AuthorizationPageRepository _authorizationPageRepository;

  /// Конструктор [AuthorizationPageModel]

  AuthorizationPageModel(
    this._authorizationPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// запрос на получение кода
  Future<void>? getCode({
    required String phone,
    // required String type,
  }) async {
    final body = <String, dynamic>{
      'phone': phone,
      // 'type': type,
    };
    late final Code? res;
    await ExceptionHandler.shellException(() async {
      await _authorizationPageRepository.getCode(body);
    });
    return;
  }

  /// Отправка кода
  Future<void> sendCode({
    required String code,
  }) async {
    final body = <String, dynamic>{
      'code': code,
    };
    await ExceptionHandler.shellException(() async {
      await _authorizationPageRepository.sendCode(body);
    });
  }

  /// регистрация
  Future<void> registration({
    required String name,
    required String surname,
    required String code,
    required bool isTrainer,
  }) async {
    final body = <String, dynamic>{
      'name': name,
      'surname': surname,
      'password': code,
      'role': isTrainer ? 'TRAINER' : 'GAMER',
    };
    await ExceptionHandler.shellException(() async {
      await _authorizationPageRepository.registration(body);
    });
  }

  /// Авторизация
  Future<void> signIn({
    required String phone,
    required String password,
  }) async {
    final body = <String, dynamic>{
      'phone': phone,
      'password': password,
    };
    await ExceptionHandler.shellException(() async {
      await _authorizationPageRepository.signIn(body);
    });
  }

  /// Восстановление пароля
  Future<void> recovery({
    required String password,
  }) async {
    final body = <String, dynamic>{
      'password': password,
    };
    await ExceptionHandler.shellException(() async {
      await _authorizationPageRepository.recovery(body);
    });
  }

  /// Изменение роли
  Future<void> changeRole({
    required bool isTrainer,
  }) async {
    final body = <String, dynamic>{
      'role': isTrainer ? 'TRAINER' : 'GAMER',
    };
    await ExceptionHandler.shellException(() async {
      await _authorizationPageRepository.changeRole(body);
    });
  }
}
