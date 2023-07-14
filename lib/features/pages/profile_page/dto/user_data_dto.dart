import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/user_notifier/dto/user_dto.dart';

part 'user_data_dto.g.dart';

/// Модель, хранящая список данных о пользователе
@JsonSerializable()
class UserDataDtO {
  /// Двнные пользователя
  @JsonKey(name: 'user')
  final UserDto? user;

  /// Рейтинг
  @JsonKey(name: 'rating')
  final RatingDto? rating;

  /// Показатели
  @JsonKey(name: 'indicators')
  final Indicators? indicators;

  /// Конструктор [UserDataDtO]
  UserDataDtO({
    required this.user,
    required this.rating,
    required this.indicators,
  });

  /// Преобразование из json
  factory UserDataDtO.fromJson(Map<String, dynamic> json) =>
      _$UserDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<UserDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<UserDataDtO> list = <UserDataDtO>[];
    list = parsedJson.map((i) => UserDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$UserDataDtOToJson(this);
}

///Показатели
@JsonSerializable()
class Indicators {
  /// Игры
  @JsonKey(name: 'games')
  final num? games;

  /// Эффективность
  @JsonKey(name: 'efficiency')
  final num? efficiency;

  /// Достижения
  @JsonKey(name: 'trophy')
  final Trophy? trophy;

  /// Конструктор [Indicators]
  Indicators({
    required this.efficiency,
    required this.trophy,
    required this.games,
  });

  /// Преобразование из json
  factory Indicators.fromJson(Map<String, dynamic> json) =>
      _$IndicatorsFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<Indicators> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<Indicators> list = <Indicators>[];
    list = parsedJson.map((i) => Indicators.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$IndicatorsToJson(this);
}

///Достижения
@JsonSerializable()
class Trophy {
  /// Получено
  @JsonKey(name: 'received')
  final num? received;

  /// Всего
  @JsonKey(name: 'total')
  final num? total;

  /// Конструктор [Trophy]
  Trophy({
    required this.received,
    required this.total,
  });

  /// Преобразование из json
  factory Trophy.fromJson(Map<String, dynamic> json) => _$TrophyFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<Trophy> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<Trophy> list = <Trophy>[];
    list = parsedJson.map((i) => Trophy.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$TrophyToJson(this);
}
