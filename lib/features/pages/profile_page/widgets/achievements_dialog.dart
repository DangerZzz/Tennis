import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';

///
class AchievementsDialog extends StatelessWidget {
  ///
  final VoidCallback back;

  ///
  final double width;

  ///
  final bool isInfo;

  ///
  final List<Achievement> achievements;

  ///
  const AchievementsDialog({
    required this.width,
    required this.back,
    required this.achievements,
    required this.isInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Container(
          height: isInfo ? 426 : 380,
          width: width * .8,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: isInfo
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        achievements[0].name,
                        style: AppTextStyles().bold_18_24.copyWith(
                              color: AppColors().primaryText,
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Способ получения:',
                        style: AppTextStyles().regular_12_16.copyWith(
                              color: AppColors().secondaryText,
                            ),
                      ),
                      Text(
                        'Проведите тренировку, выполнив не'
                        ' менее 3х ударов “Smash” и '
                        'не попав в аут или сетку.',
                        style: AppTextStyles().medium_16_21.copyWith(
                              color: AppColors().primaryText,
                            ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: 135,
                        height: 135,
                        child: Image.asset(
                          achievements[0].url,
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
                      const SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: back,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors().accentGreen,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 10,
                            ),
                            child: Center(
                              child: Text(
                                'Ясно',
                                style: AppTextStyles().bold_16_21.copyWith(
                                      color: AppColors().white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Разблокирован трофей!',
                          style: AppTextStyles().regular_14_19.copyWith(
                                color: AppColors().secondaryText,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 230,
                        child: Swiper(
                          autoplay: true,
                          autoplayDelay: 1800,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(
                                  achievements[index].name,
                                  style: AppTextStyles().bold_18_24.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: Image.asset(
                                    achievements[index].url,
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
                              ],
                            );
                          },
                          itemCount: achievements.length,
                          pagination: PaginationBuilder(key),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: back,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors().accentGreen,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 10,
                            ),
                            child: Center(
                              child: Text(
                                achievements.length > 1
                                    ? 'Получить все'
                                    : 'Получить',
                                style: AppTextStyles().bold_16_21.copyWith(
                                      color: AppColors().white,
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
      ),
    );
  }
}

///
class PaginationBuilder extends SwiperPlugin {
  ///
  final Key? key;

  ///
  const PaginationBuilder(
    this.key,
  );

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    const color = Color.fromRGBO(217, 217, 217, 1);
    final activeColor = AppColors().secondaryText;
    final list = <Widget>[];
    final itemCount = config.itemCount;
    final activeIndex = config.activeIndex;

    for (var i = 0; i < itemCount; ++i) {
      final active = i == activeIndex;
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            height: active ? 16 : 12,
            width: active ? 16 : 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: active ? activeColor : color,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Align(
        key: key,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: list,
        ),
      ),
    );
  }
}
