import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/repository/trainer_page_repository.dart';

/// mock repository
class MockTrainerPageRepository implements TrainerPageRepository {
  ///

  @override
  Future<String> sendQrData(Map<String, dynamic> body) async {
    return '';
  }

  @override
  Future<UserInfo?> getUserInfo() async {
    return null;
  }
}
