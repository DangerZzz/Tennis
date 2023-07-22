import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/user_notifier/domain/user.dart';

///
class ProviderModel extends ChangeNotifier {
  ///
  User get user => _user;
  late User _user;

  /// Подзрузка данных пользователя + обновление
  Future<void> updateUserData({
    String? newName,
    String? newSurname,
    String? newBackgroundImageUrl,
    String? newAvatarImageUrl,
    CharactersInfo? newCharacters,
  }) async {
    if (newBackgroundImageUrl?.isNotEmpty ?? false) {
      //ignore: unnecessary_statements
      _user.backgroundImageUrl == newBackgroundImageUrl;
    }

    if (newAvatarImageUrl?.isNotEmpty ?? false) {
      //ignore: unnecessary_statements
      _user.avatarImageUrl == newAvatarImageUrl;
    }

    if (newName?.isNotEmpty ?? false) {
      //ignore: unnecessary_statements
      _user.name == newName;
    }

    if (newSurname?.isNotEmpty ?? false) {
      //ignore: unnecessary_statements
      _user.surname == newSurname;
    }

    if (newCharacters != null) {
      //ignore: unnecessary_statements
      _user.charactersInfo == newCharacters;
    }

    notifyListeners();
  }
}
