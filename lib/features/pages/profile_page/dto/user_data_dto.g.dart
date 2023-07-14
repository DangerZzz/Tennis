// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataDtO _$UserDataDtOFromJson(Map<String, dynamic> json) => UserDataDtO(
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      rating: json['rating'] == null
          ? null
          : RatingDto.fromJson(json['rating'] as Map<String, dynamic>),
      indicators: json['indicators'] == null
          ? null
          : Indicators.fromJson(json['indicators'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataDtOToJson(UserDataDtO instance) =>
    <String, dynamic>{
      'user': instance.user,
      'rating': instance.rating,
      'indicators': instance.indicators,
    };

Indicators _$IndicatorsFromJson(Map<String, dynamic> json) => Indicators(
      efficiency: json['efficiency'] as num?,
      trophy: json['trophy'] == null
          ? null
          : Trophy.fromJson(json['trophy'] as Map<String, dynamic>),
      games: json['games'] as num?,
    );

Map<String, dynamic> _$IndicatorsToJson(Indicators instance) =>
    <String, dynamic>{
      'games': instance.games,
      'efficiency': instance.efficiency,
      'trophy': instance.trophy,
    };

Trophy _$TrophyFromJson(Map<String, dynamic> json) => Trophy(
      received: json['received'] as num?,
      total: json['total'] as num?,
    );

Map<String, dynamic> _$TrophyToJson(Trophy instance) => <String, dynamic>{
      'received': instance.received,
      'total': instance.total,
    };
