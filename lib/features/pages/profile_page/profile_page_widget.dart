import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/fade_indexed_stack.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/pages/game_page.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/pages/information_page.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/pages/statistics_page.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/pages/workout_information_page.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_wm.dart';

/// Main widget for ProfilePage module
class ProfilePageWidget extends ElementaryWidget<IProfilePageWidgetModel> {
  ///
  const ProfilePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultProfilePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IProfilePageWidgetModel wm) {
    return SafeArea(
      child: EntityStateNotifierBuilder<UserInfo>(
        listenableEntityState: wm.userInfo,
        loadingBuilder: (_, __) =>
            const Center(child: AdaptiveActivityIndicator()),
        builder: (_, state) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                fit: StackFit.passthrough,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: Image.asset(
                      state?.backgroundImageUrl ??
                          'lib/features/pages/profile_page/assets/images/profile_background.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: GestureDetector(
                      onTap: wm.toSettingsPage,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: AppColors().primaryText,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(
                          TennisIcons.settings,
                          color: AppColors().white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 64,
                    child: EntityStateNotifierBuilder<bool>(
                      listenableEntityState: wm.achievementsButtonIsLoading,
                      builder: (_, isLoading) => GestureDetector(
                        onTap: () {
                          if (!(isLoading ?? true)) {
                            wm.toAchievementsPage();
                          }
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: AppColors().primaryText,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: (isLoading ?? true)
                              ? const AdaptiveActivityIndicator(
                                  brightness: Brightness.dark,
                                )
                              : Icon(
                                  TennisIcons.trophy,
                                  color: AppColors().white,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: wm.width / 2 - 45,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors().white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 72,
                          height: 72,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: OctoImage(
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              placeholderBuilder: (context) => const Center(
                                child: AdaptiveActivityIndicator(),
                              ),
                              errorBuilder: (c, e, s) => SizedBox(
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/error_placeholder.svg',
                                    colorFilter: ColorFilter.mode(
                                      AppColors().accentGreen,
                                      BlendMode.srcIn,
                                    ),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                              image: Image.network(
                                state?.avatarUrl ?? '',
                              ).image,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  '${state?.surname ?? ''} ${state?.name ?? ''}',
                  style: AppTextStyles()
                      .medium_18_24
                      .copyWith(color: AppColors().primaryText),
                ),
              ),
              if (state?.rank.isNotEmpty ?? false)
                Center(
                  child: Text(
                    state?.rank ?? '',
                    style: AppTextStyles()
                        .regular_14_19
                        .copyWith(color: AppColors().secondaryText),
                  ),
                ),

              // TODO(daniil): удалить перед релизом, пока на всякий случай пусть
              // const SizedBox(
              //   height: 12,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     DecoratedBox(
              //       decoration: BoxDecoration(
              //         color: AppColors().primaryText,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 16,
              //           vertical: 5,
              //         ),
              //         child: Text(
              //           'TOP 14',
              //           style: AppTextStyles().medium_14_19.copyWith(
              //                 color: AppColors().accentGreen,
              //               ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 4,
              //     ),
              //     const Icon(
              //       Icons.arrow_upward,
              //       size: 18,
              //     ),
              //     Text(
              //       '+2',
              //       style: AppTextStyles().regular_12_16,
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 22,
              ),
              if (state?.currentLevel != null)
                Container(
                  width: wm.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors().gradientStart,
                        AppColors().gradientStart.withOpacity(0),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors().white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                '${state?.currentLevel}',
                                style: AppTextStyles().regular_14_19.copyWith(
                                      color: AppColors().accentGreen,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${state?.points} очков',
                          style: AppTextStyles()
                              .regular_16_21
                              .copyWith(color: AppColors().white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors().white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                '${state?.nextLevel}',
                                style: AppTextStyles().regular_14_19.copyWith(
                                      color: AppColors().accentGreen,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: EntityStateNotifierBuilder<int>(
                  listenableEntityState: wm.index,
                  builder: (_, state) => state != 3
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: wm.onInformation,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: state == 0
                                      ? AppColors().accentGreen
                                      : AppColors().primaryText,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    'Информация',
                                    style: AppTextStyles()
                                        .medium_14_19
                                        .copyWith(color: AppColors().white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: wm.onGame,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: state == 1
                                      ? AppColors().accentGreen
                                      : AppColors().primaryText,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    'Игра',
                                    style: AppTextStyles()
                                        .medium_14_19
                                        .copyWith(color: AppColors().white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: wm.onStatistics,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: state == 2
                                      ? AppColors().accentGreen
                                      : AppColors().primaryText,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    'Статистика',
                                    style: AppTextStyles()
                                        .medium_14_19
                                        .copyWith(color: AppColors().white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : WorkoutInformationPage(wm: wm),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: EntityStateNotifierBuilder<int>(
                  listenableEntityState: wm.index,
                  builder: (_, state) => state != 3
                      ? FadeIndexedStack(
                          index: state!.toInt(),
                          children: [
                            InformationPage(wm: wm),
                            GamePage(wm: wm),
                            StatisticsPage(wm: wm),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
