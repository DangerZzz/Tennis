///Сущность достижения
class Achievement {
  /// ссылка на изображение
  final String url;

  /// название достижения
  final String name;

  /// описание достижения
  final String description;

  /// флаг получения
  final bool isGetting;

  /// дата получения достижения
  final String? date;

  ///конструктор [Achievement]
  Achievement({
    required this.name,
    required this.url,
    required this.isGetting,
    required this.description,
    required this.date,
  });
}
