///Сущность страницы информация
class CharactersInfo {
  /// возраст
  final String? age;

  /// рост
  final String? height;

  /// лет в теннисе
  final String? ageInTennis;

  /// форхэнд
  final String? forehand;

  /// бэкхенд
  final String? backhand;

  /// техничность
  final String? technicality;

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
