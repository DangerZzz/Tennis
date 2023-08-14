import 'package:json_annotation/json_annotation.dart';

part 'game_data_dto.g.dart';

/// Модель, хранящая список данных страницы "лучшие"
@JsonSerializable()
class GameDataDtO {
  /// Приходящие данные
  @JsonKey(name: '_id')
  final String id;

  /// Приходящие данные
  @JsonKey(name: 'sections')
  final List<String>? sections;

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

  /// Конструктор [GameDataDtO]
  GameDataDtO({
    required this.time,
    required this.id,
    required this.complexity,
    required this.status,
    required this.sections,
    required this.level,
    required this.gamer,
  });

  /// Преобразование из json
  factory GameDataDtO.fromJson(Map<String, dynamic> json) =>
      _$GameDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<GameDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<GameDataDtO> list = <GameDataDtO>[];
    list = parsedJson.map((i) => GameDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$GameDataDtOToJson(this);
}
