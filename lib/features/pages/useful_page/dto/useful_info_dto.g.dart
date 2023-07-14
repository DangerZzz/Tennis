// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useful_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsefulInfoDtO _$UsefulInfoDtOFromJson(Map<String, dynamic> json) =>
    UsefulInfoDtO(
      advice: UsefulDataDto.fromJson(json['advice'] as Map<String, dynamic>),
      seeAlso: (json['seeAlso'] as List<dynamic>)
          .map((e) => UsefulDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsefulInfoDtOToJson(UsefulInfoDtO instance) =>
    <String, dynamic>{
      'advice': instance.advice,
      'seeAlso': instance.seeAlso,
    };
