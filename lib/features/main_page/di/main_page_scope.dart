import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/main_page/main_screen_model.dart';

///
class MainPageScope extends IMainPageScope {
  late final MainScreenModel _mainScreenModel;
  final ErrorHandler _errorHandler;

  // @override
  // Function? scrollToTop;

  @override
  MainScreenModel get mainScreenModel => _mainScreenModel;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  // @override
  // set scrollToTop(Function? value) {
  //   _scrollToTop = value;
  // }
  //

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
  // /// функция скролла в начало страницы
  // Function? get scrollToTop;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Модель виджета главного экрана
  MainScreenModel get mainScreenModel;
}
