import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/temp/api/client.dart';
import 'package:soft_weather_tennis/features/temp/repository/mock/mock_temp_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/temp/repository/temp_screen_repository.dart';
import 'package:soft_weather_tennis/features/temp/screens/temp_screen/temp_screen_model.dart';

/// Интерфейс Scope для экранов фичи Authorization
abstract class ITempScreenScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Authorization
  TempScreenModel get tempScreenModel;
}

/// Scope для оформления заказов
class TempScreenScope implements ITempScreenScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final TempScreenClient _tempScreenClient;

  late final TempScreenModel _tempScreenModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  TempScreenModel get tempScreenModel => _tempScreenModel;

  /// Конструткор [TempScreenScope]
  TempScreenScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _tempScreenClient = TempScreenClient(_dio);

    _initTempScreenModel();
  }

  void _initTempScreenModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockTempScreenRepository()
        : TempScreenRepository(_tempScreenClient);
    _tempScreenModel = TempScreenModel(repository, errorHandler);
  }
}
