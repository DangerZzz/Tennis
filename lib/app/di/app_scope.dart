import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:soft_weather_tennis/app/tools/dio_tools.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/user_notifier/api/client.dart';
import 'package:soft_weather_tennis/user_notifier/domain/login_code.dart';
import 'package:soft_weather_tennis/user_notifier/domain/token_storage.dart';
import 'package:soft_weather_tennis/user_notifier/repository/mock/mock_user_repository.dart';
import 'package:soft_weather_tennis/user_notifier/repository/user_repository.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';
import 'package:soft_weather_tennis/util/default_error_handler.dart';
import 'package:soft_weather_tennis/util/header_version_app.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final String _appVersion;
  late final String _buildVersion;
  late final String _apiVersion;
  late final String _platform;
  late final LoginCode _loginCode;

  late final Map<String, dynamic> _headersVersion;
  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final VoidCallback _applicationRebuilder;
  late final Coordinator _coordinator;
  late final UserNotifier _userNotifier;
  late final TokenStorage _tokenStorage;
  late final UserRepository _userRepository;

  ///
  Map<String, dynamic> get headersVersion => _headersVersion;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  VoidCallback get applicationRebuilder => _applicationRebuilder;

  @override
  Coordinator get coordinator => _coordinator;

  @override
  UserNotifier get userNotifier => _userNotifier;

  @override
  TokenStorage get tokenStorage => _tokenStorage;

  /// Create an instance [AppScope].
  AppScope({
    required VoidCallback applicationRebuilder,
  }) : _applicationRebuilder = applicationRebuilder {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[
      CustomInterceptorsWrapper(
        delta: 5,
        onError: (e, handler) async {
          if (e.error is SocketException &&
              (e.error as SocketException).osError?.errorCode != null) {
            final opts = Options(
              method: e.requestOptions.method,
              headers: e.requestOptions.headers,
            );
            try {
              final cloneReq = await dio.request<Map<String, dynamic>>(
                e.requestOptions.path,
                options: opts,
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );
              return handler.resolve(cloneReq);
            } on Exception catch (_) {
              handler.reject(e);
              rethrow;
            }
          }
          handler.next(e);
        },
      ),
      QueuedInterceptorsWrapper(
        onRequest: (response, handler) async {
          if (response.headers['cookie'] == null) {
            _dio.options.headers['cookie'] = '';
            try {
              _dio.options.headers['cookie'] = await _userNotifier.getTokens();
              handler.next(response);
            } on DioError catch (e) {
              handler.reject(e, true);
            }
          } else {
            return handler.next(response);
          }
        },
      ),
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          if (response.headers['set-cookie'] != null) {
            String cookie;
            for (final element in response.headers['set-cookie']!) {
              cookie = element;
              if (cookie.contains('code=')) {
                final newToken = cookie;
                response.requestOptions.headers['Cookie'] = '$newToken;';
                _dio.options.headers['Cookie'] = '$newToken;';
                await _userNotifier.setCookieToken();
              }
              if (cookie.contains('refresh=')) {
                final refreshToken = cookie;
                await _userNotifier.setRefreshToken(refreshToken);
              }
              if (cookie.contains('token=')) {
                final accessToken = cookie;
                await _userNotifier.setAccessToken(accessToken);
              }
            }
            _dio.options.headers['cookie'] = await _userNotifier.getTokens();
          }
          handler.next(response);
        },
        onError: (e, handler) async {
          if (e.response?.headers['set-cookie'] != null) {
            String cookie;
            for (final element in e.response!.headers['set-cookie']!) {
              cookie = element;
              if (cookie.contains('code=')) {
                final newToken = cookie;
                e.response?.requestOptions.headers['Cookie'] = '$newToken;';
                _dio.options.headers['Cookie'] = '$newToken;';
                await _userNotifier.setCookieToken();
              }
              if (cookie.contains('refresh=')) {
                final refreshToken = cookie;
                await _userNotifier.setRefreshToken(refreshToken);
              }
              if (cookie.contains('token=')) {
                final accessToken = cookie;
                await _userNotifier.setAccessToken(accessToken);
              }
            }
            _dio.options.headers['cookie'] = await _userNotifier.getTokens();
          }
          handler.next(e);
        },
      ),
    ];

    _appVersion = headerVersionApp.appVersion!;
    _buildVersion = headerVersionApp.buildNumber!;
    _platform = headerVersionApp.platform!;
    _apiVersion = headerVersionApp.apiVersion!;
    _headersVersion = _initHeaders();
    _dio = _initDio(additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    _loginCode = LoginCode();
    _initSession();
    _coordinator = Coordinator(
      codeBioLogin: _loginCode.codeHash?.isNotEmpty ?? false,
    );

    /// Иницилизации моделей страниц тут
  }

  Map<String, dynamic> _initHeaders() {
    final headers = <String, dynamic>{
      'api-version': _apiVersion,
      'app-version': _appVersion,
      'build-number': _buildVersion,
      'platform': _platform,
    };
    return headers;
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 10);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment<AppConfig>.instance().config.url
      ..connectTimeout = timeout.inMilliseconds
      ..receiveTimeout = timeout.inMilliseconds
      ..sendTimeout = timeout.inMilliseconds
      ..headers['content-Type'] = 'application/json'
      ..headers.addAll(headersVersion);

    // if (Environment<AppConfig>.instance().useMock) {
    //   dio.options
    //     ..headers['X-BX-Csrf-Token'] = 'csrftoken'
    //     ..headers['cookie'] = 'sdgsd;';
    // }

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      final proxyUrl = Environment<AppConfig>.instance().config.proxyUrl;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client.findProxy = (uri) {
          return 'PROXY $proxyUrl';
        };
      }
      if (Environment<AppConfig>.instance().isDebug) {
        client.badCertificateCallback = (_, __, ___) {
          return true;
        };
      }
      return client;
    };

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment<AppConfig>.instance().isDebug) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    return dio;
  }

  Future<void> _initSession() async {
    _tokenStorage = TokenStorage();
    _userNotifier = UserNotifier(dio: _dio, errorHandler: _errorHandler);
    _userRepository = Environment<AppConfig>.instance().useMock
        ? MockUserRepository()
        : UserRepository(UserClient(_dio));
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  Coordinator get coordinator;

  /// Сущность-обертка над пользователем и всеми его сервисами
  UserNotifier get userNotifier;

  /// Сущность-обертка над пользователем и всеми его сервисами
  TokenStorage get tokenStorage;
}
