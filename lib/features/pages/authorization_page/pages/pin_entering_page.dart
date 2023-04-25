import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_wm.dart';

///Страница ввода pin-кода
class PinEnteringPage extends StatelessWidget {
  ///
  final IAuthorizationPageWidgetModel wm;

  ///
  const PinEnteringPage({
    required this.wm,
    Key? key,
  }) : super(key: key);

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
                  'lib/features/pages/authorization_page/assets/images/registration_background.png',
                  fit: BoxFit.contain,
                ),
              ),
              EntityStateNotifierBuilder<bool>(
                listenableEntityState: wm.equalsPin,
                builder: (_, state) => Padding(
                  padding: EdgeInsets.fromLTRB(
                    16.0,
                    32,
                    16,
                    state! ? 10 : 32,
                  ),
                  child: EntityStateNotifierBuilder<bool>(
                    listenableEntityState: wm.biometricEnterFlag,
                    builder: (_, flag) => EntityStateNotifierBuilder<bool>(
                      listenableEntityState: wm.firstEnter,
                      builder: (_, firstEnter) => TextField(
                        controller: wm.pinController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [wm.pinMaskFormatter],
                        onChanged: (_) {
                          wm.pinButtonAvailabilityFunction();
                        },
                        decoration: InputDecoration(
                          suffixIcon: flag!
                              ? GestureDetector(
                                  onTap: wm.biometricEnter,
                                  child: const Icon(
                                    TennisIcons.face_id,
                                    size: 22,
                                  ),
                                )
                              : null,
                          suffixIconColor: AppColors().accentGreen,
                          hintText: firstEnter!
                              ? 'Придумайте пинкод для авторизации'
                              : 'Введите пинкод для авторизации',
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
                            borderSide:
                                BorderSide(color: AppColors().accentGreen),
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
                ),
              ),
              EntityStateNotifierBuilder<bool>(
                listenableEntityState: wm.pinButtonAvailability,
                builder: (_, state) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      if (state!) {
                        wm.setPin(wm.pinController.text);
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
              DoubleSourceBuilder<EntityState<bool>, EntityState<bool>>(
                firstSource: wm.firstEnter,
                secondSource: wm.biometricEnterFlag,
                builder: (_, state, bio) => ((state?.data ?? false) ||
                        (bio?.data ?? false))
                    ? const SizedBox()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Text(
                              'Забыли данные для входа?',
                              style: AppTextStyles()
                                  .light_12_16
                                  .copyWith(color: AppColors().secondaryText),
                            ),
                          ),
                          GestureDetector(
                            onTap: wm.toRestorePass,
                            child: Center(
                              child: Text(
                                'Помощь со входом в систему.',
                                style: AppTextStyles()
                                    .semibold_12_16
                                    .copyWith(color: AppColors().secondaryText),
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
}
