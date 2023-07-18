import 'package:json_annotation/json_annotation.dart';

part 'statistics_data_dto.g.dart';

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class StatisticsDataDtO {
  /// id игры
  @JsonKey(name: '_id')
  final String? id;

  /// Эффективность
  @JsonKey(name: 'efficiency')
  final num? efficiency;

  /// Дата
  @JsonKey(name: 'completedAt')
  final String? completedAt;

  /// Конструктор [StatisticsDataDtO]
  StatisticsDataDtO({
    required this.efficiency,
    required this.id,
    required this.completedAt,
  });

  /// Преобразование из json
  factory StatisticsDataDtO.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<StatisticsDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<StatisticsDataDtO> list = <StatisticsDataDtO>[];
    list = parsedJson.map((i) => StatisticsDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$StatisticsDataDtOToJson(this);
}
