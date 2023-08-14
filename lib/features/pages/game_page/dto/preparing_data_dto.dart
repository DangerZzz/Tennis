import 'package:json_annotation/json_annotation.dart';

part 'preparing_data_dto.g.dart';

/// Модель, хранящая подготовки к тренировке
@JsonSerializable()
class PreparingDataDtO {
  /// time
  @JsonKey(name: 'time')
  final num? time;

  /// сеты
  @JsonKey(name: 'sections')
  final num? sets;

  /// геймы
  @JsonKey(name: 'items')
  final num? games;

  /// описание
  @JsonKey(name: 'hits')
  final List<String>? hits;

  /// Конструктор [PreparingDataDtO]
  PreparingDataDtO({
    required this.hits,
    required this.sets,
    required this.games,
    required this.time,
  });

  /// Преобразование из json
  factory PreparingDataDtO.fromJson(Map<String, dynamic> json) =>
      _$PreparingDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<PreparingDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<PreparingDataDtO> list = <PreparingDataDtO>[];
    list = parsedJson.map((i) => PreparingDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$PreparingDataDtOToJson(this);
}
