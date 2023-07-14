import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

///
@JsonSerializable()
class UserDto {
  /// id
  @JsonKey(name: '_id')
  final String id;

  /// имя
  @JsonKey(name: 'name')
  final String? name;

  /// характеристики
  @JsonKey(name: 'characteristics')
  final Characteristics? characteristics;

  /// изображение
  @JsonKey(name: 'avatar')
  final AvatarDto? avatar;

  /// Обложка
  @JsonKey(name: 'wallpaper')
  final AvatarDto? wallpaper;

  /// Конструктор [UserDto]
  UserDto({
    required this.id,
    required this.name,
    required this.avatar,
    required this.characteristics,
    required this.wallpaper,
  });

  /// Преобразование из json
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<UserDto> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<UserDto> list = <UserDto>[];
    list = parsedJson.map((i) => UserDto.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

///
@JsonSerializable()
class AvatarDto {
  /// id
  @JsonKey(name: '_id')
  final String? id;

  /// тип
  @JsonKey(name: 'type')
  final String? type;

  /// изображение
  @JsonKey(name: 'src')
  final String? src;

  /// изображение
  @JsonKey(name: 'cover')
  final String? cover;

  /// Конструктор [AvatarDto]
  AvatarDto({
    required this.id,
    required this.type,
    required this.cover,
    required this.src,
  });

  /// Преобразование из json
  factory AvatarDto.fromJson(Map<String, dynamic> json) =>
      _$AvatarDtoFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<AvatarDto> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<AvatarDto> list = <AvatarDto>[];
    list = parsedJson.map((i) => AvatarDto.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$AvatarDtoToJson(this);
}

///
@JsonSerializable()
class Characteristics {
  /// возраст
  @JsonKey(name: 'age')
  final num? age;

  /// рост
  @JsonKey(name: 'height')
  final num? height;

  /// количество лет в теннисе
  @JsonKey(name: 'tennis_year')
  final num? tennisYear;

  /// forehand
  @JsonKey(name: 'forehand')
  final String? forehand;

  /// backhand
  @JsonKey(name: 'backhand')
  final String? backhand;

  /// Техничность
  @JsonKey(name: 'technicality')
  final num? technicality;

  /// Тренер
  @JsonKey(name: 'trainer')
  final String? trainer;

  /// Конструктор [Characteristics]
  Characteristics({
    required this.age,
    required this.height,
    required this.backhand,
    required this.technicality,
    required this.trainer,
    required this.forehand,
    required this.tennisYear,
  });

  /// Преобразование из json
  factory Characteristics.fromJson(Map<String, dynamic> json) =>
      _$CharacteristicsFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<Characteristics> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<Characteristics> list = <Characteristics>[];
    list = parsedJson.map((i) => Characteristics.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$CharacteristicsToJson(this);
}

///
@JsonSerializable()
class RatingDto {
  /// Очки
  @JsonKey(name: 'score')
  final num? score;

  /// Прошлое значение
  @JsonKey(name: 'prevPlace')
  final num? prevPlace;

  /// Текущее значение
  @JsonKey(name: 'place')
  final num? place;

  /// Конструктор [RatingDto]
  RatingDto({
    required this.place,
    required this.prevPlace,
    required this.score,
  });

  /// Преобразование из json
  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      _$RatingDtoFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<RatingDto> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<RatingDto> list = <RatingDto>[];
    list = parsedJson.map((i) => RatingDto.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$RatingDtoToJson(this);
}
