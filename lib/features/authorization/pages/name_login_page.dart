import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/authorization/authorization_page_wm.dart';

///Страница ввода имени и фамилии
class NameLoginPage extends StatelessWidget {
  ///
  final IAuthorizationPageWidgetModel wm;

  ///
  const NameLoginPage({
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
                  'lib/features/authorization/assets/images/registration_background.png',
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 32,
                ),
                child: Text(
                  'Пожалуйста, укажите свою фамилию\n'
                  'и имя, чтобы другие игроки могли\n'
                  'Вас идентифицировать.',
                  style: AppTextStyles().regular_16_21,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: TextField(
                  controller: wm.nameController,
                  keyboardType: TextInputType.name,
                  onChanged: (_) {
                    wm.nameEnterButtonAvailabilityFunction();
                  },
                  decoration: InputDecoration(
                    hintText: 'Ваше имя',
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: wm.surnameController,
                  keyboardType: TextInputType.name,
                  onChanged: (_) {
                    wm.nameEnterButtonAvailabilityFunction();
                  },
                  decoration: InputDecoration(
                    hintText: 'Фамилия',
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
                listenableEntityState: wm.nameButtonAvailability,
                builder: (_, state) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      if (state!) {
                        wm.setName(
                          wm.nameController.text,
                          wm.surnameController.text,
                        );
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
                            'Войти',
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
}
