import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/util/default_error_handler.dart';
import 'package:soft_weather_tennis/util/header_version_app.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final String _appVersion;
  late final String _buildVersion;
  late final String _apiVersion;
  late final String _platform;

  late final Map<String, dynamic> _headersVersion;
  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final VoidCallback _applicationRebuilder;
  late final Coordinator _coordinator;

  // late final WebSockets _webSockets;

  // late final UserNotifier _userNotifier;

  // @override
  ///
  Map<String, dynamic> get headersVersion => _headersVersion;

  @override
  Dio get dio => _dio;

  // @override
  // WebSockets get webSockets => _webSockets;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  VoidCallback get applicationRebuilder => _applicationRebuilder;

  @override
  Coordinator get coordinator => _coordinator;

  // @override
  // UserNotifier get userNotifier => _userNotifier;

  /// Create an instance [AppScope].
  AppScope({
    required VoidCallback applicationRebuilder,
  }) : _applicationRebuilder = applicationRebuilder {
    /// List interceptor. Fill in as needed.

    // final additionalInterceptors = <Interceptor>[
    //   CustomInterceptorsWrapper(
    //     delta: 5,
    //     onError: (e, handler) async {
    //       if (e.error is SocketException &&
    //           (e.error as SocketException).osError?.errorCode != null) {
    //         final opts = Options(
    //           method: e.requestOptions.method,
    //           headers: e.requestOptions.headers,
    //         );
    //         try {
    //           final cloneReq = await dio.request<Map<String, dynamic>>(
    //             e.requestOptions.path,
    //             options: opts,
    //             data: e.requestOptions.data,
    //             queryParameters: e.requestOptions.queryParameters,
    //           );
    //           return handler.resolve(cloneReq);
    //         } on Exception catch (_) {
    //           handler.reject(e);
    //           rethrow;
    //         }
    //       }
    //       handler.next(e);
    //     },
    //   ),
    //
    //   // Интерсептор для проверкаи наличия токенов
    //   // QueuedInterceptorsWrapper(
    //   //   onRequest: (response, handler) async {
    //   //     if (response.headers['cookie'] == null) {
    //   //       _dio.options.headers['cookie'] = '';
    //   //       try {
    //   //         final dioToken = Dio()..options = _dio.options;
    //   //         final userRepository = Environment<AppConfig>.instance().useMock
    //   //             ? MockUserRepository()
    //   //             : UserRepository(UserClient(dioToken));
    //   //         final res = await userRepository.getSession();
    //   //         _dio.options
    //   //           ..headers['X-BX-Csrf-Token'] = res.bxSessionToken
    //   //           ..headers['cookie'] = '${res.sessionToken};';
    //   //         Downloader.instance.headers = _dio.options.headers;
    //   //         handler.next(response);
    //   //       } on DioError catch (e) {
    //   //         handler.reject(e, true);
    //   //       }
    //   //     } else {
    //   //       return handler.next(response);
    //   //     }
    //   //   },
    //   // ),
    //
    //   InterceptorsWrapper(
    //     onResponse: (response, handler) async {
    //       if (response.headers['set-cookie'] != null) {
    //         final cookie = response.headers['set-cookie']![0];
    //         if (cookie.contains('PHPSESSID=')) {
    //           final newToken = cookie.split('PHPSESSID=')[1].split(';')[0];
    //           final headers = (response.requestOptions.headers['Cookie']
    //                   as String)
    //               .split(';')
    //             ..removeAt(0);
    //           response.requestOptions.headers['Cookie'] =
    //               'PHPSESSID=$newToken; ${headers.join(';')}';
    //           _dio.options.headers['Cookie'] =
    //               'PHPSESSID=$newToken; ${headers.join(';')}';
    //           Downloader.instance.headers = _dio.options.headers;
    //           final opts = Options(
    //             method: response.requestOptions.method,
    //             headers: response.requestOptions.headers,
    //           );
    //           await _userNotifier.setTokensFromHeaders();
    //           try {
    //             final cloneReq = await dio.request<Map<String, dynamic>>(
    //               response.requestOptions.path,
    //               options: opts,
    //               data: response.requestOptions.data,
    //               queryParameters: response.requestOptions.queryParameters,
    //             );
    //             return handler.resolve(cloneReq);
    //           } on Exception catch (_) {
    //             handler
    //                 .reject(DioError(requestOptions: response.requestOptions));
    //             // await tokenStorage.clearTokens();
    //             rethrow;
    //           }
    //         }
    //         if (cookie.contains('access_token')) {
    //           final accessToken =
    //               cookie.split('access_token=')[1].split(';')[0];
    //           final refreshToken =
    //               cookie.split('refresh_token=')[1].split(';')[0];
    //           await _userNotifier.setTokensAndDio(
    //             accessToken: accessToken,
    //             refreshToken: refreshToken,
    //           );
    //           final opts = Options(
    //             method: response.requestOptions.method,
    //             headers: response.requestOptions.headers,
    //           );
    //           await _userNotifier.setTokensFromHeaders();
    //           try {
    //             final cloneReq = await dio.request<Map<String, dynamic>>(
    //               response.requestOptions.path,
    //               options: opts,
    //               data: response.requestOptions.data,
    //               queryParameters: response.requestOptions.queryParameters,
    //             );
    //             return handler.resolve(cloneReq);
    //           } on Exception catch (_) {
    //             handler
    //                 .reject(DioError(requestOptions: response.requestOptions));
    //             // await tokenStorage.clearTokens();
    //             rethrow;
    //           }
    //         }
    //       }
    //       handler.next(response);
    //     },
    //     onError: (e, handler) async {
    //       if (e.response!.headers['set-cookie'] != null) {
    //         final cookie = e.response!.headers['set-cookie']![0];
    //         if (cookie.contains('PHPSESSID=')) {
    //           final newToken = cookie.split('PHPSESSID=')[1].split(';')[0];
    //           final headers = (e.response!.requestOptions.headers['Cookie']
    //                   as String)
    //               .split(';')
    //             ..removeAt(0);
    //           e.response!.requestOptions.headers['Cookie'] =
    //               'PHPSESSID=$newToken; ${headers.join(';')}';
    //           _dio.options.headers['Cookie'] =
    //               'PHPSESSID=$newToken; ${headers.join(';')}';
    //           Downloader.instance.headers = _dio.options.headers;
    //           final opts = Options(
    //             method: e.response!.requestOptions.method,
    //             headers: e.response!.requestOptions.headers,
    //           );
    //           await _userNotifier.setTokensFromHeaders();
    //           try {
    //             final cloneReq = await dio.request<Map<String, dynamic>>(
    //               e.response!.requestOptions.path,
    //               options: opts,
    //               data: e.response!.requestOptions.data,
    //               queryParameters: e.response!.requestOptions.queryParameters,
    //             );
    //             return handler.resolve(cloneReq);
    //           } on Exception catch (e) {
    //             if (e is DioError) {
    //               handler.reject(e);
    //             }
    //             // await tokenStorage.clearTokens();
    //             rethrow;
    //           }
    //         }
    //         if (cookie.contains('access_token')) {
    //           final accessToken =
    //               cookie.split('access_token=')[1].split(';')[0];
    //           final refreshToken =
    //               cookie.split('refresh_token=')[1].split(';')[0];
    //           await _userNotifier.setTokensAndDio(
    //             accessToken: accessToken,
    //             refreshToken: refreshToken,
    //           );
    //           final opts = Options(
    //             method: e.response!.requestOptions.method,
    //             headers: e.response!.requestOptions.headers,
    //           );
    //           await _userNotifier.setTokensFromHeaders();
    //           try {
    //             final cloneReq = await dio.request<Map<String, dynamic>>(
    //               e.response!.requestOptions.path,
    //               options: opts,
    //               data: e.response!.requestOptions.data,
    //               queryParameters: e.response!.requestOptions.queryParameters,
    //             );
    //             return handler.resolve(cloneReq);
    //           } on Exception catch (e) {
    //             if (e is DioError) {
    //               handler.reject(e);
    //             }
    //             // await tokenStorage.clearTokens();
    //             rethrow;
    //           }
    //         }
    //       }
    //       handler.next(e);
    //     },
    //   ),
    //   DioFirebasePerformanceInterceptor(),
    // ];

    _appVersion = headerVersionApp.appVersion!;
    _buildVersion = headerVersionApp.buildNumber!;
    _platform = headerVersionApp.platform!;
    _apiVersion = headerVersionApp.apiVersion!;
    _headersVersion = _initHeaders();
    _dio = _initDio(); //additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    // _webSockets = WebSockets.init(_errorHandler, headers: headersVersion);
    // _initSession();
    _coordinator = Coordinator(
        // codeBioLogin: _userNotifier.loginSettings.showCodeLoginScreen,
        );

    /// Иництилизации моделей страниц тут
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

  Dio _initDio() {
    //Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 10);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment<AppConfig>.instance().config.url
      ..connectTimeout = timeout.inMilliseconds
      ..receiveTimeout = timeout.inMilliseconds
      ..sendTimeout = timeout.inMilliseconds
      ..headers['content-Type'] = 'application/json'
      ..headers.addAll(headersVersion);

    if (Environment<AppConfig>.instance().useMock) {
      dio.options
        ..headers['X-BX-Csrf-Token'] = 'csrftoken'
        ..headers['cookie'] = 'sdgsd;';
    }

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

    // dio.interceptors.addAll(additionalInterceptors);

    if (Environment<AppConfig>.instance().isDebug) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    return dio;
  }

  // Future<void> _initSession() async {
  //   _userNotifier = UserNotifier(dio: _dio, errorHandler: _errorHandler);
  //   _userRepository = Environment<AppConfig>.instance().useMock
  //       ? MockUserRepository()
  //       : UserRepository(UserClient(_dio));
  // }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  // /// Объект со стримами из веб-сокетов
  // WebSockets get webSockets;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  Coordinator get coordinator;
}

// import 'package:dio/dio.dart';
// import 'package:elementary/elementary.dart';
// import 'package:soft_weather_tennis/config/app_config.dart';
// import 'package:soft_weather_tennis/config/environment/environment.dart';
// import 'package:soft_weather_tennis/features/authorization/api/client.dart';
// import 'package:soft_weather_tennis/features/authorization/authorization_page_model.dart';
// import 'package:soft_weather_tennis/features/authorization/repository/auth_screen_repository.dart';
// import 'package:soft_weather_tennis/features/authorization/repository/mock/mock_auth_screen_repositoy.dart';
//
// /// Интерфейс scope фичи авторизации
// abstract class IAuthorizationScope {
//   /// Http client.
//   Dio get dio;
//
//   /// Interface for handle error in business logic.
//   ErrorHandler get errorHandler;
//
//   /// Authorization login screen model
//   AuthorizationPageModel get authScreenModel;
// }
//
// /// Scope фичи авторизации
// class AuthorizationScope implements IAuthorizationScope {
//   final Dio _dio;
//   final ErrorHandler _errorHandler;
//   late final AuthorizationPageClient _authorizationPageClient;
//   late final AuthorizationPageModel _authorizationPageScreenModel;
//
//   @override
//   AuthorizationPageClient get authorizationPageClient =>
//       _authorizationPageClient;
//
//   @override
//   AuthorizationPageModel get authorizationPageScreenModel =>
//       _authorizationPageScreenModel;
//
//   @override
//   Dio get dio => _dio;
//
//   @override
//   ErrorHandler get errorHandler => _errorHandler;
//
//   @override
//   AuthorizationPageModel get authScreenModel => _authorizationPageScreenModel;
//
//   /// Scope для фичи - авторизация
//   AuthorizationScope({
//     required Dio dio,
//     required ErrorHandler errorHandler,
//   })  : _dio = dio,
//         _errorHandler = errorHandler {
//     _authorizationPageClient = AuthorizationPageClient(_dio);
//     _initAuthorizationPageScreenModel();
//   }
//
//   void _initAuthorizationPageScreenModel() {
//     final repository = Environment<AppConfig>.instance().useMock
//         ? MockAuthorizationPageRepository()
//         : AuthorizationPageRepository(_authorizationPageClient);
//     _authorizationPageScreenModel = _authorizationPageScreenModel =
//         AuthorizationPageModel(repository, errorHandler);
//   }
// }
