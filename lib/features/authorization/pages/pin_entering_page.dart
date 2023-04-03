import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:soft_weather_tennis/assets/icons/tennis_icons_icons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/authorization/authorization_page_wm.dart';
import 'package:soft_weather_tennis/user_notifier/domain/token_storage.dart';

///Страница ввода pin-кода
class PinEnteringPage extends StatefulWidget {
  ///
  final IAuthorizationPageWidgetModel wm;

  ///
  const PinEnteringPage({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  State<PinEnteringPage> createState() => _PinEnteringPageState();
}

class _PinEnteringPageState extends State<PinEnteringPage> {
  final _localAuthentication = LocalAuthentication();
  var _canCheckBiometric = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await _checkBiometric();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Image.asset(
                  'lib/features/authorization/assets/images/registration_background.png',
                  fit: BoxFit.contain,
                ),
              ),
              EntityStateNotifierBuilder<bool>(
                listenableEntityState: widget.wm.equalsPin,
                builder: (_, state) => Padding(
                  padding: EdgeInsets.fromLTRB(
                    16.0,
                    32,
                    16,
                    state! ? 10 : 32,
                  ),
                  child: TextField(
                    controller: widget.wm.pinController,
                    inputFormatters: [widget.wm.pinMaskFormatter],
                    onChanged: (_) {
                      widget.wm.pinButtonAvailabilityFunction();
                    },
                    decoration: InputDecoration(
                      suffixIcon: _canCheckBiometric
                          ? GestureDetector(
                              onTap: _authorizeNow,
                              child: const Icon(Tennis_icons.face_id1),
                            )
                          : null,
                      suffixIconColor: AppColors().accentGreen,
                      hintText: 'Придумайте пинкод для авторизации',
                      hintStyle: AppTextStyles().light_14_19.copyWith(
                            color: AppColors().secondaryText,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: AppColors().secondaryText),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors().accentGreen),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors().gridRed),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors().gridRed),
                      ),
                      errorText: state ? 'Код неверный' : null,
                    ),
                  ),
                ),
              ),
              EntityStateNotifierBuilder<bool>(
                listenableEntityState: widget.wm.pinButtonAvailability,
                builder: (_, state) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      if (state!) {
                        widget.wm.setPin(widget.wm.pinController.text);
                      }
                    },
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: state!
                            ? AppColors().accentGreen
                            : AppColors().secondaryText,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Center(
                          child: Text(
                            'Далее',
                            style: AppTextStyles().bold_20_27.copyWith(
                                  color: AppColors().white,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Функция проверяет устройство на наличие датчиков биометрии.
  Future<void> _checkBiometric() async {
    var canCheckBiometric = false;

    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint('$e');
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _authorizeNow() async {
    var isAuthorized = false;
    if (TokenStorage.faceID || TokenStorage.fingerPrint) {
      if (TokenStorage.code!.isNotEmpty) {
        try {
          isAuthorized = await _localAuthentication.authenticate(
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Вход в приложение',
                biometricHint: ' ',
                cancelButton: 'Отмена',
              ),
            ],
            localizedReason: 'Пожалуйста, приложите палец для авторизации',
          );
          if (isAuthorized) {
            widget.wm.toMain();
          }
        } on PlatformException catch (e) {
          debugPrint('$e');
        }
      } else {
        widget.wm.equalsPin.content(false);
      }
    }
  }
}
