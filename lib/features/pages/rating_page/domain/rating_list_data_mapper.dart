import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/dto/rating_list_dto.dart';

/// Заполнение модели [Rating] данными [RatingListDtO]
Rating ratingListDataMapper(RatingListDtO data) {
  return Rating(
    name: data.user?.name ?? '',
    avatarUrl: '',
    points: '${data.score ?? ''}',
    isUser: data.user?.isMe ?? false,
    position: data.place?.toInt() ?? 0,
  );
}
