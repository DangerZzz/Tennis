///Сущность списка статистик
class StatisticsList {
  /// эффективность
  final List<Statistics> efficiencyList;

  /// средняя эффективность
  final String averageEfficiency;

  ///конструктор [StatisticsList]
  StatisticsList({
    required this.averageEfficiency,
    required this.efficiencyList,
  });
}

///Сущность списка статистик
class Statistics {
  /// дата тренировки
  final num date;

  /// эффективность
  final num efficiency;

  /// Тип тренировки
  final String type;

  ///конструктор [StatisticsList]
  Statistics({
    required this.efficiency,
    required this.date,
    required this.type,
  });
}
