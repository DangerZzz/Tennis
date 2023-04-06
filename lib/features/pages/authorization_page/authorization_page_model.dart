import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/repository/auth_screen_repository.dart';

/// Default Elementary model for AuthorizationPage module
class AuthorizationPageModel extends ElementaryModel {
  final AuthorizationPageRepository _authorizationPageRepository;

  /// Конструктор [AuthorizationPageModel]

  AuthorizationPageModel(
    this._authorizationPageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
