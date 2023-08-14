import 'package:async/async.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/domain/entity/app_coordinate.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/player_call_page.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/di/pro_player_info_scope.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_model.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_widget.dart';

///
abstract class IProPlayerInfoPageWidgetModel extends IWidgetModel {
  /// Все данные страницы
  ListenableState<EntityState<List<ProPlayer>>> get proPlayerInfoData;

  /// Флаг поиска
  ListenableState<EntityState<bool>> get isSearching;

  /// Данные страницы
  ListenableState<EntityState<List<ProPlayer>>> get searchedList;

  /// Контроллер текста поиска
  TextEditingController get searchController;

  /// Focus текста поиска
  FocusNode get searchFocusNode;

  ///
  double get width;

  ///
  double get height;

  /// Нажатие на кнопку поиска
  void onSearchTap();

  /// Функция поиска
  Future<void> searching();

  /// Перход назад
  void back();

  /// Перход к игре
  void toGame();

  /// Перход к игроку
  void onInfo(ProPlayer player);
}

///
ProPlayerInfoPageWidgetModel defaultProPlayerInfoPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IProPlayerInfoPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.proPlayerInfoPageModel;
  return ProPlayerInfoPageWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for ProPlayerInfoPageWidget
class ProPlayerInfoPageWidgetModel
    extends WidgetModel<ProPlayerInfoPageWidget, ProPlayerInfoPageModel>
    implements IProPlayerInfoPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  double get height => MediaQuery.of(context).size.height;

  @override
  ListenableState<EntityState<List<ProPlayer>>> get proPlayerInfoData =>
      _proPlayerInfoData;

  @override
  ListenableState<EntityState<bool>> get isSearching => _isSearching;

  @override
  ListenableState<EntityState<List<ProPlayer>>> get searchedList =>
      _searchedList;

  @override
  TextEditingController get searchController => _searchController;

  @override
  FocusNode get searchFocusNode => _searchFocusNode;

  late EntityStateNotifier<List<ProPlayer>> _proPlayerInfoData;
  late EntityStateNotifier<List<ProPlayer>> _searchedList;
  late EntityStateNotifier<bool> _isSearching;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  CancelableOperation? _currentOperation;

  ///Конструктор
  ProPlayerInfoPageWidgetModel(
    ProPlayerInfoPageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _proPlayerInfoData = EntityStateNotifier<List<ProPlayer>>();
    _proPlayerInfoData.loading();

    _searchedList = EntityStateNotifier<List<ProPlayer>>();
    _searchedList.content(
      <ProPlayer>[],
    );

    _isSearching = EntityStateNotifier<bool>();
    _isSearching.content(false);

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    try {
      final data = await model.getProPlayerData(page: 1);
      _proPlayerInfoData.content(data);
    } on FormatException catch (e) {
      _proPlayerInfoData.error(e);
    }
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
        <ProPlayer>[],
      )
      ..loading();
    _currentOperation = CancelableOperation<List<ProPlayer>>.fromFuture(
      Future<List<ProPlayer>>(
        () async {
          final savedOperation = _currentOperation;
          await Future<void>.delayed(const Duration(seconds: 1));
          if (savedOperation?.isCanceled ?? false) {
            return <ProPlayer>[];
          }
          final result = await model.getProPlayerSearchData(
            search: _searchController.text,
            page: 1,
          );
          return result;
        },
      ),
    );
    final data = await _currentOperation!.value as List<ProPlayer>;

    _searchedList.content(data);
  }

  @override
  void onSearchTap() {
    final isSearchActive = _isSearching.value?.data;
    _isSearching.content(!isSearchActive!);
  }

  @override
  Future<void> back() async {
    coordinator.pop();
  }

  @override
  Future<void> onInfo(ProPlayer player) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => PlayerCallPage(
          proPlayer: player,
        ),
      ),
    );
  }

  @override
  Future<void> toGame() async {
    coordinator.navigate(
      context,
      AppCoordinate.newGamePage,
    );
  }
}
