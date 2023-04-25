///Сущность достижения
class AvatarImages {
  /// ссылка на изображение
  final String avatarUrl;

  /// название достижения
  final String avatarClippedUrl;

  /// флаг получения
  final String backImageUrl;

  /// дата получения достижения
  final String backImageClippedUrl;

  ///конструктор [AvatarImages]
  AvatarImages({
    required this.avatarUrl,
    required this.avatarClippedUrl,
    required this.backImageUrl,
    required this.backImageClippedUrl,
  });
}
