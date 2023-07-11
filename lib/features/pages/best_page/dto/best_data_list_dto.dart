import 'package:json_annotation/json_annotation.dart';

part 'best_data_list_dto.g.dart';

/// Модель, хранящая список данных страницы "лучшие"
@JsonSerializable()
class BestDataListDtO {
  /// Приходящие данные
  final BestDataDto bestData;

  /// Конструктор [BestDataListDtO]
  BestDataListDtO({
    required this.bestData,
  });

  /// Преобразование из json
  factory BestDataListDtO.fromJson(Map<String, dynamic> json) =>
      _$BestDataListDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<BestDataListDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<BestDataListDtO> list = <BestDataListDtO>[];
    list = parsedJson.map((i) => BestDataListDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$BestDataListDtOToJson(this);
}

///
@JsonSerializable()
class BestDataDto {
  /// id
  @JsonKey(name: '_id')
  final String id;

  /// Данные юзера
  @JsonKey(name: 'user')
  final UserDto user;

  /// роль
  @JsonKey(name: 'role')
  final String role;

  /// описание
  @JsonKey(name: 'description')
  final String description;

  /// Конструктор [BestDataDto]
  BestDataDto({
    required this.id,
    required this.description,
    required this.user,
    required this.role,
  });

  /// Преобразование из json
  factory BestDataDto.fromJson(Map<String, dynamic> json) =>
      _$BestDataDtoFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<BestDataDto> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<BestDataDto> list = <BestDataDto>[];
    list = parsedJson.map((i) => BestDataDto.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$BestDataDtoToJson(this);
}

///
@JsonSerializable()
class UserDto {
  /// id
  @JsonKey(name: '_id')
  final String id;

  /// имя
  @JsonKey(name: 'name')
  final String name;

  /// характеристики
  @JsonKey(name: 'characteristics')
  final Characteristics characteristics;

  /// изображение
  @JsonKey(name: 'avatar')
  final AvatarDto avatar;

  /// Конструктор [UserDto]
  UserDto({
    required this.id,
    required this.name,
    required this.avatar,
    required this.characteristics,
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
  final String id;

  /// имя
  @JsonKey(name: 'type')
  final String type;

  /// изображение
  @JsonKey(name: 'src')
  final String src;

  /// изображение
  @JsonKey(name: 'cover')
  final String cover;

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
  final num age;

  /// Конструктор [Characteristics]
  Characteristics({
    required this.age,
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
