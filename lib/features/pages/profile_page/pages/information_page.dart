import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/information.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_wm.dart';

/// Вкладка информация
class InformationPage extends StatelessWidget {
  ///
  final IProfilePageWidgetModel wm;

  ///
  const InformationPage({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<Information>(
      listenableEntityState: wm.informationData,
      loadingBuilder: (_, __) =>
          const Center(child: AdaptiveActivityIndicator()),
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Показатели',
                    style: AppTextStyles()
                        .bold_16_21
                        .copyWith(color: AppColors().primaryText),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Сыграно: ${state?.gameCount}',
                        style: AppTextStyles()
                            .regular_14_19
                            .copyWith(color: AppColors().primaryText),
                      ),
                      Text(
                        'Эффективность: ${state?.efficiency}',
                        style: AppTextStyles()
                            .regular_14_19
                            .copyWith(color: AppColors().primaryText),
                      ),
                      Row(
                        children: [
                          Text(
                            'Трофеи: ${state?.trophiesCount}',
                            style: AppTextStyles()
                                .regular_14_19
                                .copyWith(color: AppColors().primaryText),
                          ),
                          Text(
                            '/${state?.trophiesAllCount}',
                            // TODO(daniil): wm
                            style: AppTextStyles()
                                .regular_10_14
                                .copyWith(color: AppColors().secondaryText),
                          ),
                        ],
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
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Витрина трофеев',
                    style: AppTextStyles()
                        .bold_16_21
                        .copyWith(color: AppColors().primaryText),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var achievements in state!.lastTrophies) ...[
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset(
                                  achievements.url,
                                  fit: BoxFit.contain,
                                ),
                                // OctoImage(
                                //   fit: BoxFit.contain,
                                //   placeholderBuilder: (context) => const Icon(
                                //     Icons.refresh,
                                //   ),
                                //   errorBuilder: (c, e, s) => const Icon(
                                //     Icons.error,
                                //   ),
                                //   image: Image.network(
                                //     'https://picsum.photos/200',
                                //     fit: BoxFit.contain,
                                //   ).image,
                                // ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                achievements.name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppTextStyles().regular_14_19.copyWith(
                                      color: AppColors().primaryText,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Возраст',
                  style: AppTextStyles().light_14_19,
                ),
                Text(
                  state.charactersInfo.age!.isNotEmpty
                      ? state.charactersInfo.age ?? '—'
                      : '—',
                  style: AppTextStyles().medium_14_19,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors().secondaryText.withOpacity(0.2),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Рост',
                  style: AppTextStyles().light_14_19,
                ),
                Text(
                  state.charactersInfo.height!.isNotEmpty
                      ? state.charactersInfo.height ?? '—'
                      : '—',
                  style: AppTextStyles().medium_14_19,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors().secondaryText.withOpacity(0.2),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Лет в теннисе',
                  style: AppTextStyles().light_14_19,
                ),
                Text(
                  state.charactersInfo.ageInTennis!.isNotEmpty
                      ? state.charactersInfo.ageInTennis ?? '—'
                      : '—',
                  style: AppTextStyles().medium_14_19,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors().secondaryText.withOpacity(0.2),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Форхэнд',
                  style: AppTextStyles().light_14_19,
                ),
                Text(
                  state.charactersInfo.forehand!.isNotEmpty
                      ? state.charactersInfo.forehand ?? '—'
                      : '—',
                  style: AppTextStyles().medium_14_19,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors().secondaryText.withOpacity(0.2),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бэкхэнд',
                  style: AppTextStyles().light_14_19,
                ),
                Text(
                  state.charactersInfo.backhand!.isNotEmpty
                      ? state.charactersInfo.backhand ?? '—'
                      : '—',
                  style: AppTextStyles().medium_14_19,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors().secondaryText.withOpacity(0.2),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Техничность',
                  style: AppTextStyles().light_14_19,
                ),
                Text(
                  state.charactersInfo.technicality!.isNotEmpty
                      ? state.charactersInfo.technicality ?? '—'
                      : '—',
                  style: AppTextStyles().medium_14_19,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors().secondaryText.withOpacity(0.2),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Тренер',
                  style: AppTextStyles().light_14_19,
                ),
                Text(
                  state.charactersInfo.trainer!.isNotEmpty
                      ? state.charactersInfo.trainer ?? '—'
                      : '—',
                  style: AppTextStyles().medium_14_19,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          if (state.ratingPosition != 0)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage(
                    'lib/features/pages/profile_page/assets/images/rating_place_background.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors().primaryText.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors().primaryText,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: Text(
                                '${state.ratingPosition}',
                                style: AppTextStyles().regular_40_54.copyWith(
                                      color: AppColors().accentGreen,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: AppColors().accentGreen,
                          ),
                          Text(
                            '+${state.ratingChanges}',
                            style: AppTextStyles().regular_12_16.copyWith(
                                  color: AppColors().accentGreen,
                                ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      Text(
                        'Место в рейтинге',
                        style: AppTextStyles()
                            .medium_20_27
                            .copyWith(color: AppColors().white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
