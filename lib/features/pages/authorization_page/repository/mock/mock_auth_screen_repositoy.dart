import 'package:soft_weather_tennis/features/pages/authorization_page/repository/auth_screen_repository.dart';

/// mock repository
class MockAuthorizationPageRepository implements AuthorizationPageRepository {
  ///
  @override
  Future<void> getCode(Map<String, dynamic> body) async {}

  ///
  @override
  Future<void> sendCode(Map<String, dynamic> body) async {}

  ///
  @override
  Future<void>? registration(Map<String, dynamic> body) async {}

  ///
  @override
  Future<void>? signIn(Map<String, dynamic> body) async {}

  @override
  Future<void>? recovery(Map<String, dynamic> body) async {}
}
