// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTO _$DTOFromJson(Map<String, dynamic> json) => DTO(
      result: json['result'],
      status: json['status'] as String,
      error: json['error'] == null
          ? null
          : Error.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DTOToJson(DTO instance) => <String, dynamic>{
      'result': instance.result,
      'error': instance.error,
      'status': instance.status,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      code: json['code'] as String,
      message: json['message'] as String,
      info: json['info'] as String,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'info': instance.info,
    };
