// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementDataDtO _$AchievementDataDtOFromJson(Map<String, dynamic> json) =>
    AchievementDataDtO(
      name: json['name'] as String?,
      cover: json['cover'] as String?,
      received: json['received'] == null
          ? null
          : ReceivedDataDtO.fromJson(json['received'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AchievementDataDtOToJson(AchievementDataDtO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cover': instance.cover,
      'received': instance.received,
    };

ReceivedDataDtO _$ReceivedDataDtOFromJson(Map<String, dynamic> json) =>
    ReceivedDataDtO(
      date: json['date'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$ReceivedDataDtOToJson(ReceivedDataDtO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'date': instance.date,
    };
