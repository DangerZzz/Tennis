///Сущность данных о тренировке
class CurrentGameData {
  /// Таймы
  final String id;

  /// Количество сетов
  final num time;

  /// Количество сетов
  final num level;

  /// Количество сетов
  final String complexity;

  /// Список ударов
  final List<SectionsData> sections;

  ///конструктор [CurrentGameData]
  CurrentGameData({
    required this.time,
    required this.id,
    required this.sections,
    required this.complexity,
    required this.level,
  });
}

class SectionsData {
  /// Таймы
  final num position;

  /// Количество сетов
  final String status;

  /// Список ударов
  final List<ItemsData> items;

  ///конструктор [SectionsData]
  SectionsData({
    required this.position,
    required this.items,
    required this.status,
  });
}

class ItemsData {
  /// Таймы
  final num position;

  /// Количество сетов
  final String status;

  /// Список ударов
  final List<ActionsData> actions;

  ///конструктор [ItemsData]
  ItemsData({
    required this.position,
    required this.actions,
    required this.status,
  });
}

class ActionsData {
  /// Количество сетов
  final String status;

  /// Количество сетов
  final String type;

  ///конструктор [ActionsData]
  ActionsData({
    required this.type,
    required this.status,
  });
}
