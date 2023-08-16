import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/main_page/main_screen_model.dart';

/// Scope главной страницы
class MainPageScope extends IMainPageScope {
  late final MainScreenModel _mainScreenModel;
  final ErrorHandler _errorHandler;

  @override
  MainScreenModel get mainScreenModel => _mainScreenModel;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  /// Create an instance [MainPageScope].
  MainPageScope({
    required ErrorHandler errorHandler,
  }) : _errorHandler = errorHandler {
    _initMainScreenModel();
  }

  void _initMainScreenModel() {
    _mainScreenModel = MainScreenModel(errorHandler);
  }
}

/// Интерфейс Scope главного экрана
abstract class IMainPageScope {
  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель виджета главного экрана
  MainScreenModel get mainScreenModel;
}
