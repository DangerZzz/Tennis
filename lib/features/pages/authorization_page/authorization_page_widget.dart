import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/fade_indexed_stack.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/pages/name_login_page.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/pages/pin_entering_page.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/pages/registration_page.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/pages/role_page.dart';

/// Main widget for AuthorizationPage module
class AuthorizationPageWidget
    extends ElementaryWidget<IAuthorizationPageWidgetModel> {
  ///
  const AuthorizationPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultAuthorizationPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAuthorizationPageWidgetModel wm) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: EntityStateNotifierBuilder<int>(
          listenableEntityState: wm.index,
          loadingBuilder: (_, __) =>
              const Center(child: AdaptiveActivityIndicator()),
          builder: (_, state) => FadeIndexedStack(
            index: state!.toInt(),
            children: [
              ///Страница ввода телефона и кода
              RegistrationPage(wm: wm),

              /// Страница ввода pin/faceId
              PinEnteringPage(wm: wm),

              ///Страница ввода имени/фамилии
              NameLoginPage(wm: wm),

              ///Страница выбора роли
              RolePage(wm: wm),
            ],
          ),
        ),
      ),
    );
  }
}
