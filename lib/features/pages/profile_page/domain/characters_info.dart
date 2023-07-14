///Сущность страницы информация
class CharactersInfo {
  /// возраст
  final num? age;

  /// рост
  final num? height;

  /// лет в теннисе
  final num? ageInTennis;

  /// форхэнд
  final String? forehand;

  /// бэкхенд
  final String? backhand;

  /// техничность
  final num? technicality;

  /// тренер
  final String? trainer;

  ///конструктор [CharactersInfo]
  CharactersInfo({
    required this.age,
    required this.height,
    required this.ageInTennis,
    required this.forehand,
    required this.backhand,
    required this.technicality,
    required this.trainer,
  });
}
