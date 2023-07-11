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

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['_id'] as String,
      name: json['name'] as String,
      avatar: AvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      characteristics: Characteristics.fromJson(
          json['characteristics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'characteristics': instance.characteristics,
      'avatar': instance.avatar,
    };

AvatarDto _$AvatarDtoFromJson(Map<String, dynamic> json) => AvatarDto(
      id: json['_id'] as String,
      type: json['type'] as String,
      cover: json['cover'] as String,
      src: json['src'] as String,
    );

Map<String, dynamic> _$AvatarDtoToJson(AvatarDto instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'src': instance.src,
      'cover': instance.cover,
    };

Characteristics _$CharacteristicsFromJson(Map<String, dynamic> json) =>
    Characteristics(
      age: json['age'] as num,
    );

Map<String, dynamic> _$CharacteristicsToJson(Characteristics instance) =>
    <String, dynamic>{
      'age': instance.age,
    };
