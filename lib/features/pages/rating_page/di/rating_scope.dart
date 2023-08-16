import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_model.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/repository/mock/mock_rating_screen_repositoy.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/repository/rating_screen_repository.dart';

/// Интерфейс Scope для экранов фичи Rating
abstract class IRatingPageScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель страницы Rating
  RatingPageModel get ratingPageModel;
}

/// Scope рейтинга
class RatingPageScope implements IRatingPageScope {
  final Dio _dio;
  final ErrorHandler _errorHandler;
  late final RatingPageClient _ratingPageClient;

  late final RatingPageModel _ratingPageModel;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  RatingPageModel get ratingPageModel => _ratingPageModel;

  /// Конструткор [RatingPageScope]
  RatingPageScope({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler {
    _ratingPageClient = RatingPageClient(_dio);

    _initRatingPageModel();
  }

  void _initRatingPageModel() {
    final repository = Environment<AppConfig>.instance().useMock
        ? MockRatingPageRepository()
        : RatingPageRepository(_ratingPageClient);
    _ratingPageModel = RatingPageModel(repository, errorHandler);
  }
}
