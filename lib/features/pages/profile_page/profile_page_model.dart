import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/repository/profile_screen_repository.dart';

/// Default Elementary model for ProfilePage module
class ProfilePageModel extends ElementaryModel {
  final ProfilePageRepository _profilePageRepository;

  /// Конструктор [ProfilePageModel]
  ProfilePageModel(
    this._profilePageRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
