import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/user_notifier/dto/user_dto.dart';

part 'useful_data_list_dto.g.dart';

/// Модель, хранящая список данных страницы "полезное"
@JsonSerializable()
class UsefulDataListDtO {
  /// Приходящие данные
  final UsefulDataDto usefulData;

  /// Конструктор [UsefulDataListDtO]
  UsefulDataListDtO({
    required this.usefulData,
  });

  /// Преобразование из json
  factory UsefulDataListDtO.fromJson(Map<String, dynamic> json) =>
      _$UsefulDataListDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<UsefulDataListDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<UsefulDataListDtO> list = <UsefulDataListDtO>[];
    list = parsedJson.map((i) => UsefulDataListDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$UsefulDataListDtOToJson(this);
}

/// данные полезного
@JsonSerializable()
class UsefulDataDto {
  /// id
  @JsonKey(name: '_id')
  final String? id;

  /// заголовок
  @JsonKey(name: 'title')
  final String? title;

  /// Описание
  @JsonKey(name: 'content')
  final String? content;

  /// описание
  @JsonKey(name: 'cover')
  final AvatarDto? cover;

  /// Конструктор [UsefulDataDto]
  UsefulDataDto({
    required this.id,
    required this.cover,
    required this.title,
    required this.content,
  });

  /// Преобразование из json
  factory UsefulDataDto.fromJson(Map<String, dynamic> json) =>
      _$UsefulDataDtoFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<UsefulDataDto> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<UsefulDataDto> list = <UsefulDataDto>[];
    list = parsedJson.map((i) => UsefulDataDto.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$UsefulDataDtoToJson(this);
}
