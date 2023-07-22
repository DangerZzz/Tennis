import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/user_notifier/dto/user_dto.dart';

part 'avatar_data_dto.g.dart';

/// Модель, хранящая список данных страницы "лучшие"
@JsonSerializable()
class AvatarDataDtO {
  /// Приходящие данные
  @JsonKey(name: '_id')
  final String id;

  /// Приходящие данные
  @JsonKey(name: 'avatar')
  final AvatarDto avatar;

  /// Приходящие данные
  @JsonKey(name: 'wallpaper')
  final AvatarDto wallpaper;

  /// Приходящие данные
  @JsonKey(name: 'originalAvatar')
  final AvatarDto originalAvatar;

  /// Приходящие данные
  @JsonKey(name: 'originalWallpaper')
  final AvatarDto originalWallpaper;

  /// Конструктор [AvatarDataDtO]
  AvatarDataDtO({
    required this.wallpaper,
    required this.id,
    required this.avatar,
    required this.originalAvatar,
    required this.originalWallpaper,
  });

  /// Преобразование из json
  factory AvatarDataDtO.fromJson(Map<String, dynamic> json) =>
      _$AvatarDataDtOFromJson(json);

  /// Преобразование из json в лист объектов
  static Iterable<AvatarDataDtO> listFromJson(
    Iterable<Map<String, dynamic>> parsedJson,
  ) {
    Iterable<AvatarDataDtO> list = <AvatarDataDtO>[];
    list = parsedJson.map((i) => AvatarDataDtO.fromJson(i)).toList();
    return list;
  }

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$AvatarDataDtOToJson(this);
}
