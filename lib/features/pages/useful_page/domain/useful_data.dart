///Сущность страницы "полезное"
class UsefulData {
  /// текст быстрого совета
  final String fastAdvice;

  /// картинка быстрого совета
  final String fastAdviceImageUrl;

  /// Список советов
  final List<Advice> advice;

  ///конструктор [UsefulData]
  UsefulData({
    required this.fastAdvice,
    required this.fastAdviceImageUrl,
    required this.advice,
  });
}

///Сущность совета
class Advice {
  ///
  final int id;

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
