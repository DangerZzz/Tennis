import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';

///
class PlayerCard extends StatelessWidget {
  ///
  const PlayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 129,
      decoration: BoxDecoration(
        color: AppColors().white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(238, 238, 238, 0.7),
            // offset: Offset(, 2),
            spreadRadius: 0.1,
            blurRadius: 20,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          12,
          16,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 12,
              ),
              child: SizedBox(
                width: 97,
                height: 97,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  child: OctoImage(
                    width: 97,
                    height: 97,
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
                      'https://picsum.photos/500/400',
                    ).image,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Карлос Алькарас',
                        style: AppTextStyles().medium_16_21.copyWith(
                              color: AppColors().primaryText,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (var i = 0; i < 1; i++) ...[
                            Icon(
                              TennisIcons.star_filled,
                              size: 30,
                              color: AppColors().outYellow,
                            ),
                          ],
                          for (var i = 0; i < 5 - 4; i++) ...[
                            Icon(
                              TennisIcons.star_empty,
                              size: 30,
                              color: AppColors().outYellow,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Действующая 1-я ракетка',
                    style: AppTextStyles().light_12_16.copyWith(
                          color: AppColors().secondaryText,
                        ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Подробнее',
                        style: AppTextStyles().light_12_16.copyWith(
                              color: AppColors().secondaryText,
                            ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors().accentGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                            ),
                            child: Center(
                              child: Text(
                                'Вызов',
                                style: AppTextStyles().bold_12_14.copyWith(
                                      color: AppColors().white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
