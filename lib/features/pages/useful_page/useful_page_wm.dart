import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/di/useful_scope.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_model.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_widget.dart';

///
abstract class IUsefulPageWidgetModel extends IWidgetModel {
  ///
  ListenableState<EntityState<List<Advice>>> get usefulData;

  /// Контроллер для скролла данных
  ScrollController get scrollController;

  /// ширина страницы
  double get width;

  /// Обновление страницы
  Future<void> onRefresh();

  /// Страница конкретного совета
  void toInfoPage(String index);
}

///
UsefulPageWidgetModel defaultUsefulPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IUsefulPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.usefulPageModel;
  return UsefulPageWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for UsefulPageWidget
class UsefulPageWidgetModel
    extends WidgetModel<UsefulPageWidget, UsefulPageModel>
    implements IUsefulPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  final _limit = 5;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  ListenableState<EntityState<List<Advice>>> get usefulData => _usefulData;

  @override
  ScrollController get scrollController => _scrollController;

  late ScrollController _scrollController;

  late EntityStateNotifier<List<Advice>> _usefulData;

  var _page = 1;

  /// Конструктор
  UsefulPageWidgetModel(
    UsefulPageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _scrollController = ScrollController();
    _scrollController.addListener(_fetch);
    await _initLoad();
  }

  @override
  Future<void> onRefresh() async {
    await _initLoad();
  }

  @override
  Future<void> toInfoPage(String index) async {
    coordinator.navigate(
      context,
      AppCoordinate.usefulFullInfoPage,
      arguments: index,
    );
  }

  Future<void> _initLoad() async {
    _usefulData = EntityStateNotifier<List<Advice>>();
    _usefulData.loading();
    try {
      final data = await model.getUsefulData(
        limit: _limit,
        page: _page,
      );
      _usefulData.content(data);
    } on FormatException catch (e) {
      _usefulData.error(e);
    }
  }

  Future<void> _fetch() async {
    if (!_usefulData.value!.isLoading &&
        _scrollController.position.maxScrollExtent - 100 <
            _scrollController.offset) {
      if (_usefulData.value!.data!.length == _limit * _page) {
        final buf = _usefulData.value!.data!;
        _usefulData.loading(buf);
        try {
          _page++;
          final res = await model.getUsefulData(
            limit: _limit,
            page: _page,
          );
          await Future<void>.delayed(const Duration(seconds: 2));
          buf.addAll(res);
          _usefulData.content(buf);
        } on FormatException catch (e) {
          _page--;
          _usefulData.content(_usefulData.value!.data!);
        }
      }
    }
  }
}
