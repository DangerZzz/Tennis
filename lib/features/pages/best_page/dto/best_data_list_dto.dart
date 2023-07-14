import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/user_notifier/dto/user_dto.dart';

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
