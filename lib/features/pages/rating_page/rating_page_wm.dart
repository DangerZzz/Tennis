import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/di/rating_scope.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_model.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IRatingPageWidgetModel extends IWidgetModel {
  // ///
  // ListenableState<EntityState<bool>> get a;
  //
  // ///
  // String get b;
  //
  // ///
  // void c(String p);
}

///
RatingPageWidgetModel defaultRatingPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IRatingPageScope>();
  final appDependencies = context.read<IAppScope>();
  final userNotifier = appDependencies.userNotifier;
  final coordinator = appDependencies.coordinator;
  final model = scope.ratingPageModel;
  return RatingPageWidgetModel(
    model,
    coordinator: coordinator,
    userNotifier: userNotifier,
  );
}

/// Default widget model for RatingPageWidget
class RatingPageWidgetModel
    extends WidgetModel<RatingPageWidget, RatingPageModel>
    implements IRatingPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final UserNotifier _userNotifier;

  ///Конструктор
  RatingPageWidgetModel(
    RatingPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);
}
