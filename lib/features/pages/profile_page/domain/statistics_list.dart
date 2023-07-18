///Сущность списка статистик
class StatisticsList {
  /// эффективность
  final List<Statistics> efficiencyList;

  /// средняя эффективность
  final String averageEfficiency;

  /// средняя эффективность
  final String date;

  ///конструктор [StatisticsList]
  StatisticsList({
    required this.date,
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
  final String id;

  ///конструктор [StatisticsList]
  Statistics({
    required this.efficiency,
    required this.date,
    required this.id,
  });
}
