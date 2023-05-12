import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/widgets/code_field.dart';

///Страница ввода телефона и кода
class RegistrationPage extends StatefulWidget {
  ///
  final IAuthorizationPageWidgetModel wm;

  ///
  const RegistrationPage({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  /// Инициализация таймера
  Timer? _timer;

  /// Время задержки до активации кнопки отправки нового кода авторизации/регистрации.
  var _countdown = 300;

  String get _sCountdown {
    final min = _countdown ~/ 60;
    final sec = _countdown % 60;
    '$sec'.padLeft(2, '0');
    return '$min:${sec < 10 ? '0' : ''}$sec';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Image.asset(
                  'lib/features/pages/authorization_page/assets/images/registration_background.png',
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 32,
                ),
                child: TextField(
                  controller: widget.wm.phoneController,
                  inputFormatters: [widget.wm.phoneMaskFormatter],
                  onChanged: (_) {
                    widget.wm.phoneButtonAvailabilityFunction();
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Введите номер телефона',
                    hintStyle: AppTextStyles().light_14_19.copyWith(
                          color: AppColors().secondaryText,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors().secondaryText),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors().accentGreen),
                    ),
                  ),
                ),
              ),
              EntityStateNotifierBuilder<bool>(
                listenableEntityState: widget.wm.codeIsSend,
                loadingBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors().accentGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Center(
                        child: AdaptiveActivityIndicator(
                          brightness: Brightness.dark,
                        ),
                      ),
                    ),
                  ),
                ),
                builder: (_, codeIsSend) => codeIsSend!
                    ? Column(
                        children: [
                          Center(
                            child: Text(
                              'Введите код из sms',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CodeField(
                            codeTextFieldTool: widget.wm.codeTextFieldTool,
                            handler: widget.wm.handlerField,
                            enabled: true,
                          ),
                          if (_countdown != 0)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Запросить новый код можно через ',
                                    style: AppTextStyles().light_14_19.copyWith(
                                          color: AppColors().primaryText,
                                        ),
                                  ),
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: AppColors().primaryText,
                                    size: 16,
                                  ),
                                  Text(
                                    ' $_sCountdown',
                                    style: AppTextStyles().light_14_19.copyWith(
                                          color: AppColors().primaryText,
                                        ),
                                  ),
                                ],
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                widget.wm.getCode(
                                  widget.wm.phoneController.text,
                                );
                                _startTimer();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: Text(
                                  'Запросить новый код',
                                  style: AppTextStyles().light_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                              ),
                            ),
                          EntityStateNotifierBuilder<bool>(
                            listenableEntityState:
                                widget.wm.codeButtonAvailability,
                            loadingBuilder: (_, __) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: AppColors().accentGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Center(
                                    child: AdaptiveActivityIndicator(
                                      brightness: Brightness.dark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            builder: (_, codeButtonAvailability) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (codeButtonAvailability!) {
                                    widget.wm.sendCode(widget
                                        .wm
                                        .codeTextFieldTool
                                        .textEditingController
                                        .text);
                                  }
                                },
                                child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: codeButtonAvailability!
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
                                        style:
                                            AppTextStyles().bold_20_27.copyWith(
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
                      )
                    : Column(
                        children: [
                          EntityStateNotifierBuilder<bool>(
                            listenableEntityState:
                                widget.wm.phoneButtonAvailability,
                            builder: (_, phoneButtonAvailability) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (phoneButtonAvailability!) {
                                    widget.wm.getCode(
                                      widget.wm.phoneController.text,
                                    );
                                    _startTimer();
                                  }
                                },
                                child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: phoneButtonAvailability!
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
                                        'Получить код',
                                        style:
                                            AppTextStyles().bold_20_27.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }

  /// Запуск таймера задержки активации кнопки отправки нового кода авторизации/регистрации
  void _startTimer() {
    setState(() {
      _countdown = 120;
    });
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(
        () {
          if (_countdown < 1) {
            timer.cancel();
          } else {
            _countdown -= 1;
          }
        },
      ),
    );
  }
}
