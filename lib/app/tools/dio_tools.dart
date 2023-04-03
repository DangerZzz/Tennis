import 'package:dio/dio.dart';

/// Добавляет счетчик запрос и интервал запросов для error в [InterceptorsWrapper]
class CustomInterceptorsWrapper extends InterceptorsWrapper {
  final int _delta;

  late final int _step;

  final InterceptorSendCallback? _onRequest;

  final InterceptorSuccessCallback? _onResponse;

  final InterceptorErrorCallback? _onError;

  int _count = 0;

  /// Конструктор [CustomInterceptorsWrapper]
  /// Интервал повторения между запросами с ошибками высчитывается:
  /// [delta] секунд * на номер попытки.
  /// Первая попытка проходит без задержки
  /// кол-во повторений = 3
  CustomInterceptorsWrapper({
    int? delta,
    InterceptorSendCallback? onRequest,
    InterceptorSuccessCallback? onResponse,
    InterceptorErrorCallback? onError,
  })  : _delta = delta ?? 5,
        _onRequest = onRequest,
        _onResponse = onResponse,
        _onError = onError {
    _step = _delta;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_onRequest != null) {
      _onRequest!(options, handler);
    } else {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_onResponse != null) {
      _onResponse!(response, handler);
    } else {
      handler.next(response);
    }
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_onError != null && _count < 3) {
      await Future<void>.delayed(Duration(seconds: _count++ * _step));
      _onError!(err, handler);
    } else {
      if (_count >= 3) {
        _count = 0;
        handler.reject(err);
        return;
      }
      handler.next(err);
    }
  }
}
