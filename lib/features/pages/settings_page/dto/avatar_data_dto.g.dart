// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarDataDtO _$AvatarDataDtOFromJson(Map<String, dynamic> json) =>
    AvatarDataDtO(
      wallpaper: AvatarDto.fromJson(json['wallpaper'] as Map<String, dynamic>),
      id: json['_id'] as String,
      avatar: AvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      originalAvatar:
          AvatarDto.fromJson(json['originalAvatar'] as Map<String, dynamic>),
      originalWallpaper:
          AvatarDto.fromJson(json['originalWallpaper'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvatarDataDtOToJson(AvatarDataDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'avatar': instance.avatar,
      'wallpaper': instance.wallpaper,
      'originalAvatar': instance.originalAvatar,
      'originalWallpaper': instance.originalWallpaper,
    };
