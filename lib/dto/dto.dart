import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

/// Точка входа в DTO модели
@JsonSerializable()
class DTO {
  /// ответ
  final dynamic result;

  /// [Error]
  final Error? error;

  /// статус
  final String status;

  /// Конструктор [DTO]
  DTO({required this.result, required this.status, this.error});

  /// Преобразование из json
  factory DTO.fromJson(Map<String, dynamic> json) => _$DTOFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$DTOToJson(this);
}

/// Сущность, в которую записывается метрика запроса
@JsonSerializable()
class Error {
  /// код ошибки
  final String code;

  /// сообщение
  final String message;

  /// информация
  final String info;

  /// Конструктор [Error]
  Error({
    required this.code,
    required this.message,
    required this.info,
  });

  /// Преобразование из json
  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
