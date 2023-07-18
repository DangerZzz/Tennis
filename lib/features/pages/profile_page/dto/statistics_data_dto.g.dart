// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsDataDtO _$StatisticsDataDtOFromJson(Map<String, dynamic> json) =>
    StatisticsDataDtO(
      efficiency: json['efficiency'] as num?,
      id: json['_id'] as String?,
      completedAt: json['completedAt'] as String?,
    );

Map<String, dynamic> _$StatisticsDataDtOToJson(StatisticsDataDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'efficiency': instance.efficiency,
      'completedAt': instance.completedAt,
    };
