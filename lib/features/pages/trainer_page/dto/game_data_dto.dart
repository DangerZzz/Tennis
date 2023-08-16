import 'package:json_annotation/json_annotation.dart';

part 'game_data_dto.g.dart';

/// Модель, хранящая список данных страницы "лучшие"
@JsonSerializable()
class GameStartDataDtO {
  /// Приходящие данные
  @JsonKey(name: '_id')
  final String id;

  /// Сеты
  @JsonKey(name: 'sections')
  final List<SectionsDataDtO>? sections;

  /// Приходящие данные
  @JsonKey(name: 'gamer')
  final String? gamer;

  /// Приходящие данные
  @JsonKey(name: 'status')
  final String? status;

  /// Приходящие данные
  @JsonKey(name: 'level')
  final num? level;

  /// Приходящие данные
  @JsonKey(name: 'time')
  final num? time;

  /// Приходящие данные
  @JsonKey(name: 'complexity')
  final String? complexity;

  /// Конструктор [GameStartDataDtO]
  GameStartDataDtO({
    required this.time,
    required this.id,
    required this.complexity,
    required this.status,
    required this.sections,
    required this.level,
    required this.gamer,
  });

  /// Преобразование из json
  factory GameStartDataDtO.fromJson(Map<String, dynamic> json) =>
      _$GameStartDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<GameStartDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<GameStartDataDtO> list = <GameStartDataDtO>[];
    list = parsedJson.map((i) => GameStartDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$GameStartDataDtOToJson(this);
}

/// Модель, хранящая список сетов
@JsonSerializable()
class SectionsDataDtO {
  /// Приходящие данные
  @JsonKey(name: '_id')
  final String id;

  /// геймы
  @JsonKey(name: 'items')
  final List<ItemsDataDtO>? items;

  /// Приходящие данные
  @JsonKey(name: 'position')
  final num? position;

  /// Приходящие данные
  @JsonKey(name: 'status')
  final String? status;

  /// Конструктор [SectionsDataDtO]
  SectionsDataDtO({
    required this.items,
    required this.id,
    required this.position,
    required this.status,
  });

  /// Преобразование из json
  factory SectionsDataDtO.fromJson(Map<String, dynamic> json) =>
      _$SectionsDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<SectionsDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<SectionsDataDtO> list = <SectionsDataDtO>[];
    list = parsedJson.map((i) => SectionsDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$SectionsDataDtOToJson(this);
}

/// Модель, хранящая список геймов
@JsonSerializable()
class ItemsDataDtO {
  /// Приходящие данные
  @JsonKey(name: '_id')
  final String id;

  /// Удары
  @JsonKey(name: 'actions')
  final List<ActionsDataDtO>? actions;

  /// Приходящие данные
  @JsonKey(name: 'position')
  final num? position;

  /// Приходящие данные
  @JsonKey(name: 'status')
  final String? status;

  /// Приходящие данные
  @JsonKey(name: 'level')
  final num? level;

  /// Приходящие данные
  @JsonKey(name: 'complexity')
  final String? complexity;

  /// Конструктор [ItemsDataDtO]
  ItemsDataDtO({
    required this.actions,
    required this.id,
    required this.position,
    required this.status,
    required this.level,
    required this.complexity,
  });

  /// Преобразование из json
  factory ItemsDataDtO.fromJson(Map<String, dynamic> json) =>
      _$ItemsDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<ItemsDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<ItemsDataDtO> list = <ItemsDataDtO>[];
    list = parsedJson.map((i) => ItemsDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$ItemsDataDtOToJson(this);
}

/// Модель, хранящая список ударов
@JsonSerializable()
class ActionsDataDtO {
  /// Приходящие данные
  @JsonKey(name: '_id')
  final String id;

  /// Удары
  @JsonKey(name: 'type')
  final String? type;

  /// Приходящие данные
  @JsonKey(name: 'status')
  final String? status;

  /// Конструктор [ActionsDataDtO]
  ActionsDataDtO({
    required this.type,
    required this.id,
    required this.status,
  });

  /// Преобразование из json
  factory ActionsDataDtO.fromJson(Map<String, dynamic> json) =>
      _$ActionsDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<ActionsDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<ActionsDataDtO> list = <ActionsDataDtO>[];
    list = parsedJson.map((i) => ActionsDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$ActionsDataDtOToJson(this);
}
