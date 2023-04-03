import 'package:elementary/elementary.dart';
import 'package:soft_weather_tennis/features/temp/repository/temp_screen_repository.dart';
import 'package:soft_weather_tennis/features/temp/screens/temp_screen/temp_screen.dart';

/// Model fol [TempScreen].
class TempScreenModel extends ElementaryModel {
  final TempScreenRepository _tempScreenRepository;

  /// Конструктор [TempScreenModel]

  TempScreenModel(
    this._tempScreenRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
