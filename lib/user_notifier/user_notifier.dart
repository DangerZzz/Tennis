import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/user_notifier/domain/token_storage.dart';
import 'package:soft_weather_tennis/user_notifier/domain/user.dart';

/// Интерфейс обертки на сущностью пользователя
abstract class IUserNotifier extends ChangeNotifier {
  /// Телефон пользователя
  String? get phone;

  /// Имя пользователя
  String? get name;

  /// Фамилия пользователя
  String? get surname;

  /// Id пользователя
  String? get id;

  /// Функция обновления данных пользователя (обращение на бек)
  Future<void> updateUser();

  /// Разлогинить пользователя
  Future<void> logout();

  /// Загрузка данных из хранилища (токены и пр.)
  Future<void> loadStorageInfo();

  /// установка нового токена пользователя
  Future<void> updateTokens({required String token});
}

/// Оболочка над всем функционалом пользователя
class UserNotifier extends IUserNotifier {
  final _tokenStorage = TokenStorage();

  // TODO(daniil): объявлять репозиторий
  // late final UserRepository _repository;

  final Dio _dio;

  @override
  String? get name => _user?.name;

  @override
  String? get surname => _user?.surname;

  @override
  String? get phone => _user?.phone;

  @override
  String? get id => _user?.id;

  User? _user;

  /// Конуструктор [UserNotifier]
  UserNotifier({required Dio dio}) : _dio = dio {
    // TODO(daniil): реализовать инит репозитория
    // _repository = Environment<AppConfig>.instance().useMock
    //     ? MockUserRepository()
    //     : UserRepository(UserClient(_dio));
  }

  @override
  Future<void> loadStorageInfo() async {
    await _tokenStorage.refreshAccessToken();
    final token = _tokenStorage.token;
    if (token != null) {
      _dio.options.headers['access-token'] = token;
    }
  }

  @override
  Future<void> logout() async {
    _user = null;
    await _tokenStorage.deleteToken();
    _dio.options.headers.remove('access-token');
  }

  @override
  Future<void> updateTokens({required String token}) async {
    await _tokenStorage.setToken(token: token);
    _dio.options.headers['access-token'] = token;
  }

  @override
  Future<void> updateUser() {
    // TODO(daniil): метод обращения к репозиториюи заполнения сущности пользователя
    throw UnimplementedError();
  }
}
