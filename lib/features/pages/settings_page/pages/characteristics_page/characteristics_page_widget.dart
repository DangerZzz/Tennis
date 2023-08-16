import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/age_text_convertator.dart';
import 'package:soft_weather_tennis/components/custom_dropdown.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/characters_info.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/characteristics_page/characteristics_page_wm.dart';

/// Main widget for CharacteristicsPage module
class CharacteristicsPageWidget
    extends ElementaryWidget<ICharacteristicsPageWidgetModel> {
  ///
  const CharacteristicsPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultCharacteristicsPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ICharacteristicsPageWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors().white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors().white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        shadowColor: Colors.transparent,
        leading: InkWell(
          onTap: wm.onBack,
          child: Icon(
            TennisIcons.back,
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
      body: EntityStateNotifierBuilder<CharactersInfo>(
        listenableEntityState: wm.charactersInfo,
        loadingBuilder: (_, __) =>
            const Center(child: AdaptiveActivityIndicator()),
        builder: (_, charactersInfo) => Padding(
          padding: const EdgeInsets.all(16.0),
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
                        'Характеристики',
                        style: AppTextStyles().bold_16_21.copyWith(
                              color: AppColors().primaryText,
                            ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: wm.onAge,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Возраст',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.age != null &&
                                      charactersInfo?.age != 0)
                                  ? '${charactersInfo?.age}'
                                      ' ${AgeTextConvert().convertAge(charactersInfo?.age ?? 0)}'
                                  : '—',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
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
                        onTap: wm.onAgeInTennis,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Лет в теннисе',
                              style: AppTextStyles().light_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                            Text(
                              (charactersInfo?.ageInTennis != null)
                                  ? '${charactersInfo?.ageInTennis}'
                                      ' ${AgeTextConvert().convertAge(charactersInfo?.ageInTennis ?? 0)}'
                                  : '—',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Рост',
                            style: AppTextStyles().light_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          DropDownCustom(
                            items: wm.height,
                            textStyle: AppTextStyles().regular_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                            hint: Text(
                              '${charactersInfo?.height} см',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                            icon: Icon(
                              Icons.expand_more,
                              color: AppColors().secondaryText,
                              size: 18,
                            ),
                            onChanged: (state) {
                              wm.heightEdit(state as String);
                            },
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors().secondaryText.withOpacity(0.1),
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Форхэнд',
                            style: AppTextStyles().light_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          DropDownCustom(
                            items: const [
                              'Левая рука',
                              'Правая рука',
                            ],
                            textStyle: AppTextStyles().regular_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                            hint: Text(
                              charactersInfo?.forehand == 'RIGHT'
                                  ? 'Правая рука'
                                  : 'Левая рука',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                            icon: Icon(
                              Icons.expand_more,
                              color: AppColors().secondaryText,
                              size: 18,
                            ),
                            onChanged: (state) {
                              wm.forehandEdit(state as String);
                            },
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors().secondaryText.withOpacity(0.1),
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Бэкхэнд',
                            style: AppTextStyles().light_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          DropDownCustom(
                            items: const [
                              'Одноручный',
                              'Двуручный',
                            ],
                            textStyle: AppTextStyles().regular_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                            hint: Text(
                              charactersInfo?.backhand == 'ONE'
                                  ? 'Одноручный'
                                  : 'Двуручный',
                              style: AppTextStyles().regular_14_19.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                            icon: Icon(
                              Icons.expand_more,
                              color: AppColors().secondaryText,
                              size: 18,
                            ),
                            onChanged: (state) {
                              wm.backhandEdit(state as String);
                            },
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors().secondaryText.withOpacity(0.1),
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: wm.onBack,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors().secondaryText,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 46,
                          vertical: 8,
                        ),
                        child: Text(
                          'Отмена',
                          style: AppTextStyles()
                              .regular_14_19
                              .copyWith(color: AppColors().white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: wm.editCharacters,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors().accentGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 8,
                        ),
                        child: Text(
                          'Сохранить',
                          style: AppTextStyles()
                              .regular_14_19
                              .copyWith(color: AppColors().white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
