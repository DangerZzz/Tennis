///Сущность данных о тренировке
class PreparingData {
  /// Таймы
  final String time;

  /// Количество сетов
  final num sets;

  /// Количество геймов
  final num games;

  /// Список ударов
  final List<String> hits;

  ///конструктор [PreparingData]
  PreparingData({
    required this.time,
    required this.games,
    required this.sets,
    required this.hits,
  });
}
