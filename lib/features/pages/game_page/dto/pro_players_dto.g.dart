// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_players_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProPlayersDtO _$ProPlayersDtOFromJson(Map<String, dynamic> json) =>
    ProPlayersDtO(
      avatar: json['avatar'] == null
          ? null
          : AvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      name: json['name'] as String?,
      id: json['_id'] as String?,
      description: json['title'] as String?,
      rating: json['rating'] as num?,
      fullDescription: json['description'] as String?,
      ratings: json['ratings'] == null
          ? null
          : RatingsDtO.fromJson(json['ratings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProPlayersDtOToJson(ProPlayersDtO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'title': instance.description,
      'description': instance.fullDescription,
      'ratings': instance.ratings,
      'rating': instance.rating,
      'avatar': instance.avatar,
    };

RatingsDtO _$RatingsDtOFromJson(Map<String, dynamic> json) => RatingsDtO(
      complexity: json['complexity'] as num,
      endurance: json['endurance'] as num,
      impactForce: json['impactForce'] as num,
      tactic: json['tactic'] as num,
    );

Map<String, dynamic> _$RatingsDtOToJson(RatingsDtO instance) =>
    <String, dynamic>{
      'impactForce': instance.impactForce,
      'endurance': instance.endurance,
      'tactic': instance.tactic,
      'complexity': instance.complexity,
    };
