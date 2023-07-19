import 'package:json_annotation/json_annotation.dart';

part 'achievement_data_dto.g.dart';

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class AchievementDataDtO {
  /// Двнные пользователя
  @JsonKey(name: 'name')
  final String? name;

  /// Рейтинг
  @JsonKey(name: 'description')
  final String? description;

  /// Рейтинг
  @JsonKey(name: 'cover')
  final String? cover;

  /// Рейтинг
  @JsonKey(name: 'received')
  final ReceivedDataDtO? received;

  /// Конструктор [AchievementDataDtO]
  AchievementDataDtO({
    required this.name,
    required this.cover,
    required this.received,
    required this.description,
  });

  /// Преобразование из json
  factory AchievementDataDtO.fromJson(Map<String, dynamic> json) =>
      _$AchievementDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<AchievementDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<AchievementDataDtO> list = <AchievementDataDtO>[];
    list = parsedJson.map((i) => AchievementDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$AchievementDataDtOToJson(this);
}

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class ReceivedDataDtO {
  /// Двнные пользователя
  @JsonKey(name: 'status')
  final bool? status;

  /// Рейтинг
  @JsonKey(name: 'date')
  final String? date;

  /// Конструктор [ReceivedDataDtO]
  ReceivedDataDtO({
    required this.date,
    required this.status,
  });

  /// Преобразование из json
  factory ReceivedDataDtO.fromJson(Map<String, dynamic> json) =>
      _$ReceivedDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<ReceivedDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<ReceivedDataDtO> list = <ReceivedDataDtO>[];
    list = parsedJson.map((i) => ReceivedDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$ReceivedDataDtOToJson(this);
}
