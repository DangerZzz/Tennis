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

  /// Контроллер для скролла данных
  ScrollController get dataScrollController;

  /// Контроллер для скролла данных
  ScrollController get searchScrollController;

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

  final _limit = 10;

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

  @override
  ScrollController get dataScrollController => _dataScrollController;

  @override
  ScrollController get searchScrollController => _searchScrollController;

  late ScrollController _dataScrollController;
  late ScrollController _searchScrollController;
  late EntityStateNotifier<RatingList> _ratingList;
  late EntityStateNotifier<SearchRatingList> _searchedList;
  late EntityStateNotifier<bool> _isSearching;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  var _pageData = 1;
  var _pageSearch = 1;

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

    _dataScrollController = ScrollController();
    _dataScrollController.addListener(_fetchData);
    _searchScrollController = ScrollController();
    _searchScrollController.addListener(_fetchSearch);
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
          final result = await model.getSearchingRatingList(
            search: _searchController.text,
            page: 1,
          );
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
    if (name.contains(' ')) {
      final data = name.split(' ');
      return '${data.first} ${data[1].characters.first}.';
    } else {
      return name;
    }
  }

  Future<void> _fetchData() async {
    if (!_ratingList.value!.isLoading &&
        _dataScrollController.position.maxScrollExtent - 100 <
            _dataScrollController.offset) {
      if (_ratingList.value!.data!.ratingData.length == _limit * _pageData) {
        final buf = _ratingList.value!.data!.ratingData;
        _ratingList.loading(
          RatingList(
            ratingData: buf,
          ),
        );
        try {
          _pageData++;
          final res = await model.getRatingList(page: _pageData);
          await Future<void>.delayed(const Duration(seconds: 2));
          buf.addAll(res.ratingData);
          _ratingList.content(
            RatingList(
              ratingData: buf,
            ),
          );
        } on FormatException catch (e) {
          _pageData--;
          _ratingList.content(
            RatingList(
              ratingData: _ratingList.value!.data!.ratingData,
            ),
          );
        }
      }
    }
  }

  Future<void> _fetchSearch() async {
    if (!_searchedList.value!.isLoading &&
        _searchScrollController.position.maxScrollExtent - 100 <
            _searchScrollController.offset) {
      if (_searchedList.value!.data!.ratingData.length ==
          _limit * _pageSearch) {
        final buf = _searchedList.value!.data!.ratingData;
        _searchedList.loading(
          SearchRatingList(
            ratingData: buf,
            probablyRatingData: [],
          ),
        );
        try {
          _pageSearch++;
          final res = await model.getRatingList(page: _pageSearch);
          await Future<void>.delayed(const Duration(seconds: 2));
          buf.addAll(res.ratingData);
          _searchedList.content(
            SearchRatingList(
              ratingData: buf,
              probablyRatingData: [],
            ),
          );
        } on FormatException catch (e) {
          _pageSearch--;
          _searchedList.content(
            SearchRatingList(
              ratingData: _searchedList.value!.data!.ratingData,
              probablyRatingData: [],
            ),
          );
        }
      }
    }
  }

  Future<void> _initLoad() async {
    _ratingList = EntityStateNotifier<RatingList>();
    _isSearching = EntityStateNotifier<bool>();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _searchedList = EntityStateNotifier<SearchRatingList>();
    _ratingList.loading();
    _isSearching.content(false);
    _searchedList.content(
      SearchRatingList(
        ratingData: [],
        probablyRatingData: [],
      ),
    );

    try {
      final data = await model.getRatingList(page: 1);
      _ratingList.content(data);
    } on FormatException catch (e) {
      _ratingList.error(e);
    }
  }
}
