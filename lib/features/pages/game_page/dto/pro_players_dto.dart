import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/user_notifier/dto/user_dto.dart';

part 'pro_players_dto.g.dart';

/// Модель, хранящая список данных страницы "лучшие"
@JsonSerializable()
class ProPlayersDtO {
  /// id
  @JsonKey(name: '_id')
  final String? id;

  /// имя
  @JsonKey(name: 'name')
  final String? name;

  /// заголовок
  @JsonKey(name: 'title')
  final String? description;

  /// описание
  @JsonKey(name: 'description')
  final String? fullDescription;

  /// список рейтинга по значениям
  @JsonKey(name: 'ratings')
  final RatingsDtO? ratings;

  /// общий рейтинг
  @JsonKey(name: 'rating')
  final num? rating;

  /// аватар
  @JsonKey(name: 'avatar')
  final AvatarDto? avatar;

  /// Конструктор [ProPlayersDtO]
  ProPlayersDtO({
    required this.avatar,
    required this.name,
    required this.id,
    required this.description,
    required this.rating,
    required this.fullDescription,
    required this.ratings,
  });

  /// Преобразование из json
  factory ProPlayersDtO.fromJson(Map<String, dynamic> json) =>
      _$ProPlayersDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<ProPlayersDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<ProPlayersDtO> list = <ProPlayersDtO>[];
    list = parsedJson.map((i) => ProPlayersDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$ProPlayersDtOToJson(this);
}

/// Модель, хранящая список данных страницы "лучшие"
@JsonSerializable()
class RatingsDtO {
  /// сила удара
  @JsonKey(name: 'impactForce')
  final num impactForce;

  /// выносливость
  @JsonKey(name: 'endurance')
  final num endurance;

  /// тактика
  @JsonKey(name: 'tactic')
  final num tactic;

  /// сложность
  @JsonKey(name: 'complexity')
  final num complexity;

  /// Конструктор [RatingsDtO]
  RatingsDtO({
    required this.complexity,
    required this.endurance,
    required this.impactForce,
    required this.tactic,
  });

  /// Преобразование из json
  factory RatingsDtO.fromJson(Map<String, dynamic> json) =>
      _$RatingsDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<RatingsDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<RatingsDtO> list = <RatingsDtO>[];
    list = parsedJson.map((i) => RatingsDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$RatingsDtOToJson(this);
}
