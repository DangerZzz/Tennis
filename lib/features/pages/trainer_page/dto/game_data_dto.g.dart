// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDataDtO _$GameDataDtOFromJson(Map<String, dynamic> json) => GameDataDtO(
      time: json['time'] as num?,
      id: json['_id'] as String,
      complexity: json['complexity'] as String?,
      status: json['status'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      level: json['level'] as num?,
      gamer: json['gamer'] as String?,
    );

Map<String, dynamic> _$GameDataDtOToJson(GameDataDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sections': instance.sections,
      'gamer': instance.gamer,
      'status': instance.status,
      'level': instance.level,
      'time': instance.time,
      'complexity': instance.complexity,
    };
