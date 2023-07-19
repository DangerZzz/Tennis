import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/achievement_data_dto.dart';

/// Заполнение модели [Achievement] данными [AchievementDataDtO]
Achievement achievementDataMapper(AchievementDataDtO data) {
  final year = int.parse('${data.received?.date?.substring(0, 4)}');
  final month = int.parse('${data.received?.date?.substring(5, 7)}');
  final day = int.parse('${data.received?.date?.substring(8, 10)}');
  var date = '';

  if (month < 10) {
    date = '$day.0$month.$year';
  } else {
    date = '$day.$month.$year';
  }
  return Achievement(
    name: data.name ?? '',
    date: date,
    isGetting: data.received?.status ?? false,
    url: data.cover ?? '',
    description: data.description ?? '',
  );
}
