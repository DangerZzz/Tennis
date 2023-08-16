import 'package:json_annotation/json_annotation.dart';

part 'code_temp_dto.g.dart';

/// Удалить как будет смс сервис
@JsonSerializable()
class CodeDtO {
  /// id
  @JsonKey(name: 'code')
  final String code;

  /// id
  @JsonKey(name: 'isRegistered')
  final bool isRegistered;

  /// Конструктор [CodeDtO]
  CodeDtO({
    required this.code,
    required this.isRegistered,
  });

  /// Преобразование из json
  factory CodeDtO.fromJson(Map<String, dynamic> json) =>
      _$CodeDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<CodeDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<CodeDtO> list = <CodeDtO>[];
    list = parsedJson.map((i) => CodeDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$CodeDtOToJson(this);
}
