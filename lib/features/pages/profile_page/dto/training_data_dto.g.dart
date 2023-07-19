// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingDataDtO _$TrainingDataDtOFromJson(Map<String, dynamic> json) =>
    TrainingDataDtO(
      completedAt: json['completedAt'] as String?,
      efficiency: json['efficiency'] as num?,
      level: json['level'] as num?,
      complexity: json['complexity'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SetsDtO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrainingDataDtOToJson(TrainingDataDtO instance) =>
    <String, dynamic>{
      'completedAt': instance.completedAt,
      'level': instance.level,
      'efficiency': instance.efficiency,
      'complexity': instance.complexity,
      'sections': instance.sections,
    };

SetsDtO _$SetsDtOFromJson(Map<String, dynamic> json) => SetsDtO(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GameDtO.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] as num?,
    );

Map<String, dynamic> _$SetsDtOToJson(SetsDtO instance) => <String, dynamic>{
      'items': instance.items,
      'position': instance.position,
    };

GameDtO _$GameDtOFromJson(Map<String, dynamic> json) => GameDtO(
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => ActionsDtO.fromJson(e as Map<String, dynamic>))
          .toList(),
      efficiency: json['efficiency'] as num?,
      hits: json['hits'] == null
          ? null
          : HitsDtO.fromJson(json['hits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameDtOToJson(GameDtO instance) => <String, dynamic>{
      'actions': instance.actions,
      'efficiency': instance.efficiency,
      'hits': instance.hits,
    };

ActionsDtO _$ActionsDtOFromJson(Map<String, dynamic> json) => ActionsDtO(
      type: json['type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ActionsDtOToJson(ActionsDtO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'status': instance.status,
    };

HitsDtO _$HitsDtOFromJson(Map<String, dynamic> json) => HitsDtO(
      grid: json['GRID'] as num?,
      out: json['OUT'] as num?,
      worked: json['WORKED'] as num?,
    );

Map<String, dynamic> _$HitsDtOToJson(HitsDtO instance) => <String, dynamic>{
      'WORKED': instance.worked,
      'GRID': instance.grid,
      'OUT': instance.out,
    };
