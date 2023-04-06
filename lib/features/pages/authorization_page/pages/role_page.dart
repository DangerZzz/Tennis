import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/authorization_page/authorization_page_wm.dart';

///Страница выбора роли
class RolePage extends StatelessWidget {
  ///
  final IAuthorizationPageWidgetModel wm;

  ///
  const RolePage({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'lib/features/pages/authorization_page/assets/images/role_background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Смена роли',
                style: AppTextStyles().regular_14_19.copyWith(
                      color: AppColors().secondaryText,
                    ),
              ),
            ),
            Center(
              child: Text(
                'Выберите роль',
                style: AppTextStyles().regular_23_27.copyWith(
                      color: AppColors().white,
                    ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () =>
                    wm.completeRegistration(false), // TODO(daniil): исправить
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors().white,
                      width: 0.3,
                    ),
                    color: const Color.fromRGBO(168, 219, 25, 0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(
                          child: Text(
                            'Я игрок'.toUpperCase(),
                            style: AppTextStyles().regular_23_27.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors().accentGreen,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () =>
                    wm.completeRegistration(true), // TODO(daniil): исправить

                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors().white,
                      width: 0.3,
                    ),
                    color: const Color.fromRGBO(168, 219, 25, 0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(
                          child: Text(
                            'Я тренер'.toUpperCase(),
                            style: AppTextStyles().regular_23_27.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors().accentGreen,
                                ),
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
      ],
    );
  }
}
