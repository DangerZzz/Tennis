import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/tennis_icons_icons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/settings_page_wm.dart';

/// Main widget for SettingsPage module
class SettingsPageWidget extends ElementaryWidget<ISettingsPageWidgetModel> {
  ///
  const SettingsPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultSettingsPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingsPageWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors().white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors().white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          // onTap: () => Navigator.pop(context),
          child: Icon(
            Tennis_icons.back1,
            color: AppColors().primaryText,
            size: 12,
          ),
        ),
        title: Text(
          'Настройки',
          style: AppTextStyles().bold_24_32.copyWith(
                color: AppColors().primaryText,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Tennis_icons.profile,
                                color: AppColors().accentGreen,
                                size: 26,
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
                            Tennis_icons.edit1,
                            size: 16,
                            color: AppColors().secondaryText,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Tennis_icons.user1,
                                color: AppColors().accentGreen,
                                size: 26,
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
                                Tennis_icons.edit1,
                                size: 16,
                                color: AppColors().secondaryText,
                              ),
                            ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Tennis_icons.role1,
                                color: AppColors().accentGreen,
                                size: 26,
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
                                Tennis_icons.edit1,
                                size: 16,
                                color: AppColors().secondaryText,
                              ),
                            ],
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
                      Row(
                        children: [
                          Icon(
                            Tennis_icons.back1,
                            color: AppColors().accentGreen,
                            size: 26,
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
                      Row(
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              EntityStateNotifierBuilder<CharactersInfo>(
                listenableEntityState: wm.charactersInfo,
                loadingBuilder: (_, __) =>
                    const Center(child: AdaptiveActivityIndicator()),
                builder: (_, charactersInfo) => DecoratedBox(
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
                          'Характеристики',
                          style: AppTextStyles().bold_16_21.copyWith(
                                color: AppColors().primaryText,
                              ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Возраст',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.age?.isNotEmpty ?? false)
                                  ? '${charactersInfo?.age} лет'
                                  : '—',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Рост',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.height?.isNotEmpty ?? false)
                                  ? '${charactersInfo?.height} см'
                                  : '—',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Лет в теннисе',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.ageInTennis?.isNotEmpty ?? false)
                                  ? '${charactersInfo?.ageInTennis} года'
                                  : '—',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Форхэнд',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.forehand?.isNotEmpty ?? false)
                                  ? '${charactersInfo?.forehand}'
                                  : '—',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Бэкхэнд',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.backhand?.isNotEmpty ?? false)
                                  ? '${charactersInfo?.backhand}'
                                  : '—',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Техничность',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.technicality?.isNotEmpty ??
                                      false)
                                  ? '${charactersInfo?.technicality} %'
                                  : '—',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Тренер',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.trainer?.isNotEmpty ?? false)
                                  ? '${charactersInfo?.trainer}'
                                  : '—',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().secondaryText,
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
                          height: 32,
                        ),
                        Center(
                          child: Container(
                            width: 164,
                            decoration: BoxDecoration(
                              color: AppColors().accentGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Tennis_icons.edit1,
                                    color: AppColors().white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Редактировать',
                                    style: AppTextStyles()
                                        .medium_14_19
                                        .copyWith(color: AppColors().white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
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
              // DropDown(
              //   items: const ['Все достижения', 'Полученные', 'Еще не открыты'],
              //   showUnderline: false,
              //   hint: Text(
              //     'Все достижения',
              //     style: AppTextStyles().bold_16_21,
              //   ),
              //   icon: Icon(
              //     Icons.expand_more,
              //     color: AppColors().secondaryText,
              //   ),
              //   onChanged: (state) {
              //     // setState(
              //     //   () {
              //     //     if (state == 'Все достижения') {
              //     //       showGetting = true;
              //     //       showNotGetting = true;
              //     //     }
              //     //     if (state == 'Полученные') {
              //     //       showGetting = true;
              //     //       showNotGetting = false;
              //     //     }
              //     //     if (state == 'Еще не открыты') {
              //     //       showGetting = false;
              //     //       showNotGetting = true;
              //     //     }
              //     //   },
              //     // );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
