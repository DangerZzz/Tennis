// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useful_data_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsefulDataListDtO _$UsefulDataListDtOFromJson(Map<String, dynamic> json) =>
    UsefulDataListDtO(
      usefulData:
          UsefulDataDto.fromJson(json['usefulData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsefulDataListDtOToJson(UsefulDataListDtO instance) =>
    <String, dynamic>{
      'usefulData': instance.usefulData,
    };

UsefulDataDto _$UsefulDataDtoFromJson(Map<String, dynamic> json) =>
    UsefulDataDto(
      id: json['_id'] as String?,
      cover: json['cover'] == null
          ? null
          : AvatarDto.fromJson(json['cover'] as Map<String, dynamic>),
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$UsefulDataDtoToJson(UsefulDataDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'cover': instance.cover,
    };
