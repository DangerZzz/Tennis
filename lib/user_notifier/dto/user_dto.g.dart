// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['_id'] as String,
      name: json['name'] as String?,
      avatar: json['avatar'] == null
          ? null
          : AvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      characteristics: json['characteristics'] == null
          ? null
          : Characteristics.fromJson(
              json['characteristics'] as Map<String, dynamic>),
      wallpaper: json['wallpaper'] == null
          ? null
          : AvatarDto.fromJson(json['wallpaper'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'characteristics': instance.characteristics,
      'avatar': instance.avatar,
      'wallpaper': instance.wallpaper,
    };

AvatarDto _$AvatarDtoFromJson(Map<String, dynamic> json) => AvatarDto(
      id: json['_id'] as String?,
      type: json['type'] as String?,
      cover: json['cover'] as String?,
      src: json['src'] as String?,
    );

Map<String, dynamic> _$AvatarDtoToJson(AvatarDto instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'src': instance.src,
      'cover': instance.cover,
    };

Characteristics _$CharacteristicsFromJson(Map<String, dynamic> json) =>
    Characteristics(
      age: json['age'] as num?,
      height: json['height'] as num?,
      backhand: json['backhand'] as String?,
      technicality: json['technicality'] as num?,
      trainer: json['trainer'] as String?,
      forehand: json['forehand'] as String?,
      tennisYear: json['tennis_year'] as num?,
    );

Map<String, dynamic> _$CharacteristicsToJson(Characteristics instance) =>
    <String, dynamic>{
      'age': instance.age,
      'height': instance.height,
      'tennis_year': instance.tennisYear,
      'forehand': instance.forehand,
      'backhand': instance.backhand,
      'technicality': instance.technicality,
      'trainer': instance.trainer,
    };

RatingDto _$RatingDtoFromJson(Map<String, dynamic> json) => RatingDto(
      place: json['place'] as num?,
      prevPlace: json['prevPlace'] as num?,
      score: json['score'] as num?,
    );

Map<String, dynamic> _$RatingDtoToJson(RatingDto instance) => <String, dynamic>{
      'score': instance.score,
      'prevPlace': instance.prevPlace,
      'place': instance.place,
    };
