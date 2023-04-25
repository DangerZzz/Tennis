import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_wm.dart';

///
class MainSettingsPage extends StatelessWidget {
  ///
  final ISettingsPageWidgetModel wm;

  ///
  const MainSettingsPage({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(241, 241, 241, 1),
                  offset: Offset(1, 2),
                  spreadRadius: 0.1,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Аккаунт',
                    style: AppTextStyles().bold_16_21.copyWith(
                          color: AppColors().primaryText,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: wm.toAvatarPage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              TennisIcons.profile_circle,
                              color: AppColors().accentGreen,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Аватар профиля',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                          ],
                        ),
                        Icon(
                          TennisIcons.forward,
                          size: 14,
                          color: AppColors().secondaryText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Divider(
                    color: AppColors().secondaryText.withOpacity(0.1),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: wm.toEditName,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              TennisIcons.user_tag,
                              color: AppColors().accentGreen,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Имя и Фамилия',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${wm.userInfo.name} ${wm.userInfo.surname[0]}.',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(
                              TennisIcons.forward,
                              size: 14,
                              color: AppColors().secondaryText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Divider(
                    color: AppColors().secondaryText.withOpacity(0.1),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: wm.changeRole,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              TennisIcons.user_updade,
                              color: AppColors().accentGreen,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Сменить роль',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              wm.userNotifier.isTrainer ? 'Тренер' : 'Игрок',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(
                              TennisIcons.forward,
                              size: 14,
                              color: AppColors().secondaryText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Divider(
                    color: AppColors().secondaryText.withOpacity(0.1),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: wm.toCharacteristicsPage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              TennisIcons.user_edit,
                              color: AppColors().accentGreen,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Характеристики',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                          ],
                        ),
                        Icon(
                          TennisIcons.forward,
                          size: 14,
                          color: AppColors().secondaryText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Divider(
                    color: AppColors().secondaryText.withOpacity(0.1),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(
                        TennisIcons.logout,
                        color: AppColors().accentGreen,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Выйти',
                        style: AppTextStyles().regular_14_19.copyWith(
                              color: AppColors().primaryText,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Divider(
                    color: AppColors().secondaryText.withOpacity(0.1),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: wm.deleteAccount,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Удалить аккаунт',
                          style: AppTextStyles().regular_14_19.copyWith(
                                color: AppColors().secondaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Есть вопросы? ',
                style: AppTextStyles()
                    .light_12_16
                    .copyWith(color: AppColors().secondaryText),
              ),
              Text(
                'Обратиться в тех. поддержку.',
                style: AppTextStyles()
                    .bold_12_14
                    .copyWith(color: AppColors().secondaryText),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
