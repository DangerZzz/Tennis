import 'package:soft_weather_tennis/features/pages/authorization_page/domain/code.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/repository/auth_screen_repository.dart';

/// mock repository
class MockAuthorizationPageRepository implements AuthorizationPageRepository {
  ///
  @override
  Future<Code> getCode(Map<String, dynamic> body) async {
    return Code(
      code: '',
      isRegistered: true,
    );
  }

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

  @override
  Future<void>? changeRole(Map<String, dynamic> body) async {}
}
