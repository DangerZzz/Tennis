// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsMessageDto _$WsMessageDtoFromJson(Map<String, dynamic> json) => WsMessageDto(
      json['action'] as String,
      json['data'],
    );

Map<String, dynamic> _$WsMessageDtoToJson(WsMessageDto instance) =>
    <String, dynamic>{
      'action': instance.action,
      'data': instance.data,
    };
