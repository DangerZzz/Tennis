import 'package:json_annotation/json_annotation.dart';

part 'training_data_dto.g.dart';

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class TrainingDataDtO {
  /// Двнные пользователя
  @JsonKey(name: 'completedAt')
  final String? completedAt;

  /// Двнные пользователя
  @JsonKey(name: 'level')
  final num? level;

  /// Рейтинг
  @JsonKey(name: 'efficiency')
  final num? efficiency;

  /// Рейтинг
  @JsonKey(name: 'complexity')
  final String? complexity;

  /// Рейтинг
  @JsonKey(name: 'sections')
  final List<SetsDtO>? sections;

  /// Конструктор [TrainingDataDtO]
  TrainingDataDtO({
    required this.completedAt,
    required this.efficiency,
    required this.level,
    required this.complexity,
    required this.sections,
  });

  /// Преобразование из json
  factory TrainingDataDtO.fromJson(Map<String, dynamic> json) =>
      _$TrainingDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<TrainingDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<TrainingDataDtO> list = <TrainingDataDtO>[];
    list = parsedJson.map((i) => TrainingDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$TrainingDataDtOToJson(this);
}

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class SetsDtO {
  /// Двнные пользователя
  @JsonKey(name: 'items')
  final List<GameDtO>? items;

  /// Двнные пользователя
  @JsonKey(name: 'position')
  final num? position;

  /// Конструктор [SetsDtO]
  SetsDtO({
    required this.items,
    required this.position,
  });

  /// Преобразование из json
  factory SetsDtO.fromJson(Map<String, dynamic> json) =>
      _$SetsDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<SetsDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<SetsDtO> list = <SetsDtO>[];
    list = parsedJson.map((i) => SetsDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$SetsDtOToJson(this);
}

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class GameDtO {
  /// Двнные пользователя
  @JsonKey(name: 'actions')
  final List<ActionsDtO>? actions;

  /// Двнные пользователя
  @JsonKey(name: 'efficiency')
  final num? efficiency;

  /// Двнные пользователя
  @JsonKey(name: 'hits')
  final HitsDtO? hits;

  /// Конструктор [GameDtO]
  GameDtO({
    required this.actions,
    required this.efficiency,
    required this.hits,
  });

  /// Преобразование из json
  factory GameDtO.fromJson(Map<String, dynamic> json) =>
      _$GameDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<GameDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<GameDtO> list = <GameDtO>[];
    list = parsedJson.map((i) => GameDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$GameDtOToJson(this);
}

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class ActionsDtO {
  /// Двнные пользователя
  @JsonKey(name: 'type')
  final String? type;

  /// Двнные пользователя
  @JsonKey(name: 'status')
  final String? status;

  /// Конструктор [ActionsDtO]
  ActionsDtO({
    required this.type,
    required this.status,
  });

  /// Преобразование из json
  factory ActionsDtO.fromJson(Map<String, dynamic> json) =>
      _$ActionsDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<ActionsDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<ActionsDtO> list = <ActionsDtO>[];
    list = parsedJson.map((i) => ActionsDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$ActionsDtOToJson(this);
}

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class HitsDtO {
  /// Двнные пользователя
  @JsonKey(name: 'WORKED')
  final num? worked;

  /// Двнные пользователя
  @JsonKey(name: 'GRID')
  final num? grid;

  /// Двнные пользователя
  @JsonKey(name: 'OUT')
  final num? out;

  /// Конструктор [HitsDtO]
  HitsDtO({
    required this.grid,
    required this.out,
    required this.worked,
  });

  /// Преобразование из json
  factory HitsDtO.fromJson(Map<String, dynamic> json) =>
      _$HitsDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<HitsDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<HitsDtO> list = <HitsDtO>[];
    list = parsedJson.map((i) => HitsDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$HitsDtOToJson(this);
}