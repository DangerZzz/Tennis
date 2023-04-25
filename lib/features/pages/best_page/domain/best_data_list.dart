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
  ///id
  final int id;

  /// картинка
  final String imageUrl;

  /// количество медалей
  final int medalCount;

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
    required this.id,
    required this.imageUrl,
    required this.age,
    required this.name,
    required this.rank,
    required this.description,
    required this.medalCount,
    required this.topCount,
  });
}
