import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/statistics_data_dto.dart';

/// Заполнение модели [Statistics] данными [StatisticsDataDtO]
Statistics statisticsDataMapper(StatisticsDataDtO data) {
  final year = int.parse('${data.completedAt?.substring(0, 4)}');
  final month = int.parse('${data.completedAt?.substring(5, 7)}');
  final day = int.parse('${data.completedAt?.substring(8, 10)}');
  final date = DateTime(year, month, day);
  return Statistics(
    efficiency: data.efficiency ?? 0,
    date: date.millisecondsSinceEpoch / 1000,
    id: data.id ?? '',
  );
}
