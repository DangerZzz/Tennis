import 'package:async/async.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/di/rating_scope.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/search_rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_model.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_widget.dart';
import 'package:soft_weather_tennis/user_notifier/user_notifier.dart';

///
abstract class IRatingPageWidgetModel extends IWidgetModel {
  /// Данные страницы
  ListenableState<EntityState<RatingList>> get ratingList;

  /// Данные страницы
  ListenableState<EntityState<SearchRatingList>> get searchedList;

  /// Флаг активности поиска
  ListenableState<EntityState<bool>> get isSearching;

  /// Контроллер текста поиска
  TextEditingController get searchController;

  /// Focus текста поиска
  FocusNode get searchFocusNode;

  /// Обновление страницы
  Future<void> onRefresh();

  /// Нажатие на кнопку поиска
  void onSearchTap();

  /// Функция поиска
  Future<void> searching();

  /// Обрезка имени
  String substringName(String name);
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

  @override
  ListenableState<EntityState<RatingList>> get ratingList => _ratingList;

  @override
  ListenableState<EntityState<SearchRatingList>> get searchedList =>
      _searchedList;

  @override
  ListenableState<EntityState<bool>> get isSearching => _isSearching;

  @override
  TextEditingController get searchController => _searchController;

  @override
  FocusNode get searchFocusNode => _searchFocusNode;

  late EntityStateNotifier<RatingList> _ratingList;
  late EntityStateNotifier<SearchRatingList> _searchedList;
  late EntityStateNotifier<bool> _isSearching;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  CancelableOperation? _currentOperation;

  ///Конструктор
  RatingPageWidgetModel(
    RatingPageModel model, {
    required this.coordinator,
    required UserNotifier userNotifier,
  })  : _userNotifier = userNotifier,
        super(model);

  @override
  Future<void> onRefresh() async {
    await _initLoad();
  }

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _ratingList = EntityStateNotifier<RatingList>();
    _isSearching = EntityStateNotifier<bool>();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _searchedList = EntityStateNotifier<SearchRatingList>();
    await _initLoad();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Future<void> searching() async {
    _searchedList
      ..content(
        SearchRatingList(
          ratingData: [],
          probablyRatingData: [],
        ),
      )
      ..loading();
    _currentOperation = CancelableOperation<SearchRatingList>.fromFuture(
      Future<SearchRatingList>(
        () async {
          final savedOperation = _currentOperation;
          await Future<void>.delayed(const Duration(seconds: 1));
          if (savedOperation?.isCanceled ?? false) {
            return SearchRatingList(
              ratingData: [],
              probablyRatingData: [],
            );
          }
          final result = await model.getSearchingRatingList();
          return result;
        },
      ),
    );
    final data = await _currentOperation!.value as SearchRatingList;

    _searchedList.content(data);
  }

  @override
  void onSearchTap() {
    final isSearchActive = _isSearching.value?.data;
    _isSearching.content(!isSearchActive!);
  }

  @override
  String substringName(String name) {
    final data = name.split(' ');
    return '${data.first} ${data[1].characters.first}.';
  }

  Future<void> _initLoad() async {
    _ratingList.loading();
    _isSearching.content(false);
    _searchedList.content(
      SearchRatingList(
        ratingData: [],
        probablyRatingData: [],
      ),
    );

    try {
      final data = await model.getRatingList();
      _ratingList.content(data);
    } on FormatException catch (e) {
      _ratingList.error(e);
    }
  }
}
