// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTO _$DTOFromJson(Map<String, dynamic> json) => DTO(
      data: json['data'],
      status: json['status'] as bool,
      statusCode: json['statusCode'] as num,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DTOToJson(DTO instance) => <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
      'statusCode': instance.statusCode,
    };
