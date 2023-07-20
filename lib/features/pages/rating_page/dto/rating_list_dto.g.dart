// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingListDtO _$RatingListDtOFromJson(Map<String, dynamic> json) =>
    RatingListDtO(
      place: json['place'] as num?,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      score: json['score'] as num?,
    );

Map<String, dynamic> _$RatingListDtOToJson(RatingListDtO instance) =>
    <String, dynamic>{
      'user': instance.user,
      'score': instance.score,
      'place': instance.place,
    };
