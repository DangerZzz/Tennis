import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/dto/user_data_dto.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/dto/game_data_dto.dart';

/// Репозиторий для главной
class TrainerPageRepository {
  final TrainerPageClient _trainerPageClient;

  /// Конструктор [TrainerPageRepository]
  TrainerPageRepository(this._trainerPageClient);

  /// Возвращает данные страницы информация
  Future<String> sendQrData(Map<String, dynamic> body) =>
      _trainerPageClient.sendQrData(body).then(
        (dto) {
          final data =
              GameStartDataDtO.fromJson(dto.data as Map<String, dynamic>);
          return data.id;
        },
      );

  /// Возвращает данные пользователя
  Future<UserInfo?> getUserInfo() => _trainerPageClient.getUserInfo().then(
        (dto) {
          final data = UserDataDtO.fromJson(dto.data as Map<String, dynamic>);
          final res = UserInfo(
            name: data.user?.name?.split(' ')[1] ?? '',
            avatarUrl: data.user?.avatar?.src ?? '',
            surname: data.user?.name?.split(' ')[0] ?? '',
            backgroundImageUrl: data.user?.wallpaper?.src ?? '',
            currentLevel: data.rating?.prevPlace ?? 0,
            nextLevel: data.rating?.place ?? 0,
            points: data.rating?.score ?? 0,
            rank: '',
          );

          return res;
        },
      );
}
