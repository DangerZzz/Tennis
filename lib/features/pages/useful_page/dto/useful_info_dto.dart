import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/dto/useful_data_list_dto.dart';

part 'useful_info_dto.g.dart';

/// Модель, хранящая список данных страницы "полезное"
@JsonSerializable()
class UsefulInfoDtO {
  /// Совет
  @JsonKey(name: 'advice')
  final UsefulDataDto advice;

  /// Смотри так же
  @JsonKey(name: 'seeAlso')
  final List<UsefulDataDto> seeAlso;

  /// Конструктор [UsefulInfoDtO]
  UsefulInfoDtO({
    required this.advice,
    required this.seeAlso,
  });

  /// Преобразование из json
  factory UsefulInfoDtO.fromJson(Map<String, dynamic> json) =>
      _$UsefulInfoDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<UsefulInfoDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<UsefulInfoDtO> list = <UsefulInfoDtO>[];
    list = parsedJson.map((i) => UsefulInfoDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$UsefulInfoDtOToJson(this);
}
