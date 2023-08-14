// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preparing_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreparingDataDtO _$PreparingDataDtOFromJson(Map<String, dynamic> json) =>
    PreparingDataDtO(
      hits: (json['hits'] as List<dynamic>?)?.map((e) => e as String).toList(),
      sets: json['sections'] as num?,
      games: json['items'] as num?,
      time: json['time'] as num?,
    );

Map<String, dynamic> _$PreparingDataDtOToJson(PreparingDataDtO instance) =>
    <String, dynamic>{
      'time': instance.time,
      'sections': instance.sets,
      'items': instance.games,
      'hits': instance.hits,
    };
