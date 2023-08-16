import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/user_notifier/dto/user_dto.dart';

part 'rating_list_dto.g.dart';

/// Модель, хранящая список данных рейтинга
@JsonSerializable()
class RatingListDtO {
  /// Двнные пользователя
  @JsonKey(name: 'user')
  final UserDto? user;

  /// количество очков
  @JsonKey(name: 'score')
  final num? score;

  /// место
  @JsonKey(name: 'place')
  final num? place;

  /// Конструктор [RatingListDtO]
  RatingListDtO({
    required this.place,
    required this.user,
    required this.score,
  });

  /// Преобразование из json
  factory RatingListDtO.fromJson(Map<String, dynamic> json) =>
      _$RatingListDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<RatingListDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<RatingListDtO> list = <RatingListDtO>[];
    list = parsedJson.map((i) => RatingListDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$RatingListDtOToJson(this);
}
