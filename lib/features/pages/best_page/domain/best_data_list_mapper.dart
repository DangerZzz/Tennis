import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list.dart';
import 'package:soft_weather_tennis/features/pages/best_page/dto/best_data_list_dto.dart';

/// Заполнение модели [BestData] данными [BestDataDto]
BestData bestDataMapper(BestDataDto data) {
  return BestData(
    imageUrl: data.user.avatar.src,
    age: data.user.name,
    name: data.user.name,
    rank: data.role,
    description: data.description,
    topCount: 1,
  );
}
