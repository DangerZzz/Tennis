import 'package:json_annotation/json_annotation.dart';

part 'ws_message.g.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Модель сообщения web-socket
@JsonSerializable()
class WsMessageDto {
  /// событие в сообщении
  @JsonKey(name: 'action')
  final String action;

  /// Данные из события
  @JsonKey(name: 'data')
  final dynamic data;

  /// Конструктор [WsMessageDto]
  WsMessageDto(
    this.action,
    this.data,
  );

  /// Преобразование из json
  factory WsMessageDto.fromJson(Map<String, dynamic> json) =>
      _$WsMessageDtoFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$WsMessageDtoToJson(this);
}
