// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameStartDataDtO _$GameStartDataDtOFromJson(Map<String, dynamic> json) =>
    GameStartDataDtO(
      time: json['time'] as num?,
      id: json['_id'] as String,
      complexity: json['complexity'] as String?,
      status: json['status'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionsDataDtO.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: json['level'] as num?,
      gamer: json['gamer'] as String?,
    );

Map<String, dynamic> _$GameStartDataDtOToJson(GameStartDataDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sections': instance.sections,
      'gamer': instance.gamer,
      'status': instance.status,
      'level': instance.level,
      'time': instance.time,
      'complexity': instance.complexity,
    };

SectionsDataDtO _$SectionsDataDtOFromJson(Map<String, dynamic> json) =>
    SectionsDataDtO(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemsDataDtO.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
      position: json['position'] as num?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SectionsDataDtOToJson(SectionsDataDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'items': instance.items,
      'position': instance.position,
      'status': instance.status,
    };

ItemsDataDtO _$ItemsDataDtOFromJson(Map<String, dynamic> json) => ItemsDataDtO(
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => ActionsDataDtO.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
      position: json['position'] as num?,
      status: json['status'] as String?,
      level: json['level'] as num?,
      complexity: json['complexity'] as String?,
    );

Map<String, dynamic> _$ItemsDataDtOToJson(ItemsDataDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'actions': instance.actions,
      'position': instance.position,
      'status': instance.status,
      'level': instance.level,
      'complexity': instance.complexity,
    };

ActionsDataDtO _$ActionsDataDtOFromJson(Map<String, dynamic> json) =>
    ActionsDataDtO(
      type: json['type'] as String?,
      id: json['_id'] as String,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ActionsDataDtOToJson(ActionsDataDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'status': instance.status,
    };
