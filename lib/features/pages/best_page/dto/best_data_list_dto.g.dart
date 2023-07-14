// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_data_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestDataListDtO _$BestDataListDtOFromJson(Map<String, dynamic> json) =>
    BestDataListDtO(
      bestData: BestDataDto.fromJson(json['bestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BestDataListDtOToJson(BestDataListDtO instance) =>
    <String, dynamic>{
      'bestData': instance.bestData,
    };

BestDataDto _$BestDataDtoFromJson(Map<String, dynamic> json) => BestDataDto(
      id: json['_id'] as String,
      description: json['description'] as String,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      role: json['role'] as String,
    );

Map<String, dynamic> _$BestDataDtoToJson(BestDataDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'role': instance.role,
      'description': instance.description,
    };
