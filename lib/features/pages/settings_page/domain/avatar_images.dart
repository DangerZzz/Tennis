///Сущность достижения
class AvatarImages {
  /// ссылка на изображение аватара пользователя
  final String avatarUrl;

  /// ссылка на отредактированное изображение аватара пользователя
  final String avatarClippedUrl;

  /// ссылка на изображение фона пользователя
  final String backImageUrl;

  /// ссылка на отредактированное изображение фона пользователя
  final String backImageClippedUrl;

  ///конструктор [AvatarImages]
  AvatarImages({
    required this.avatarUrl,
    required this.avatarClippedUrl,
    required this.backImageUrl,
    required this.backImageClippedUrl,
  });
}
