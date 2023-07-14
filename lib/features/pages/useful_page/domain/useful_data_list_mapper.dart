import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/dto/useful_data_list_dto.dart';

/// Заполнение модели [Advice] данными [UsefulDataDto]
Advice usefulDataMapper(UsefulDataDto data) {
  return Advice(
    imageUrl: data.cover?.src ?? '',
    theme: data.title ?? '',
    text: data.content ?? '',
    id: data.id ?? '',
  );
}
