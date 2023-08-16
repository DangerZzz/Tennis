import 'package:json_annotation/json_annotation.dart';
import 'package:soft_weather_tennis/user_notifier/dto/user_dto.dart';

part 'avatar_data_dto.g.dart';

/// Модель, хранящая список данных страницы "настройки"
@JsonSerializable()
class AvatarDataDtO {
  /// Приходящие данные
  @JsonKey(name: '_id')
  final String id;

  /// данные аватара
  @JsonKey(name: 'avatar')
  final AvatarDto? avatar;

  /// данные обложки
  @JsonKey(name: 'wallpaper')
  final AvatarDto? wallpaper;

  /// Оригинал аватара
  @JsonKey(name: 'originalAvatar')
  final AvatarDto? originalAvatar;

  /// Оригинал обложки
  @JsonKey(name: 'originalWallpaper')
  final AvatarDto? originalWallpaper;

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
