import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';

///Сущность совета
class UsefulInfoData {
  ///
  final int id;

  /// картинка
  final String imageUrl;

  /// тема
  final String theme;

  /// текст
  final String text;

  /// текст
  final List<Advice> advices;

  ///конструктор [UsefulInfoData]
  UsefulInfoData({
    required this.id,
    required this.theme,
    required this.text,
    required this.imageUrl,
    required this.advices,
  });
}
