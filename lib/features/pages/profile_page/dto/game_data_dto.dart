import 'package:json_annotation/json_annotation.dart';

part 'game_data_dto.g.dart';

/// Модель, хранящая список данных о игре
@JsonSerializable()
class GameDataDtO {
  /// Максимальный уровень
  @JsonKey(name: 'maxLevel')
  final num? maxLevel;

  /// Максимальная сложность
  @JsonKey(name: 'maxComplexity')
  final String? maxComplexity;

  /// Конструктор [GameDataDtO]
  GameDataDtO({
    required this.maxLevel,
    required this.maxComplexity,
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
