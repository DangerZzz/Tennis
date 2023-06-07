///Сущность страницы "лучшие"
class BestDataList {
  /// Список лучших
  final List<BestData> bestData;

  ///конструктор [BestDataList]
  BestDataList({
    required this.bestData,
  });
}

///Сущность лучшего
class BestData {
  /// картинка
  final String imageUrl;

  /// имя + фамилия
  final String name;

  /// возраст
  final String age;

  /// звание
  final String rank;

  /// место в топе
  final int topCount;

  /// текст
  final String description;

  ///конструктор [BestData]
  BestData({
    required this.imageUrl,
    required this.age,
    required this.name,
    required this.rank,
    required this.description,
    required this.topCount,
  });
}
