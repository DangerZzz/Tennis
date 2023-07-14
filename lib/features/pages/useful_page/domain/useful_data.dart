///Сущность совета
class Advice {
  ///
  final String id;

  /// картинка
  final String imageUrl;

  /// тема
  final String theme;

  /// текст
  final String text;

  ///конструктор [Advice]
  Advice({
    required this.id,
    required this.theme,
    required this.text,
    required this.imageUrl,
  });
}
