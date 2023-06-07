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
  final String name;

  ///
  final String description;

  ///
  final String imageUrl;

  ///
  final int rating;

  ///
  final VoidCallback info;

  ///
  final VoidCallback call;

  ///
  const PlayerCard({
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.info,
    required this.call,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nameSub;
    if (name.length > 12) {
      nameSub = '${name.substring(0, 12)}...';
    } else {
      nameSub = name;
    }
    return Container(
      height: 129,
      decoration: BoxDecoration(
        color: AppColors().white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(238, 238, 238, 0.7),
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
                      imageUrl,
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
                        nameSub,
                        style: AppTextStyles().medium_16_21.copyWith(
                              color: AppColors().primaryText,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (var i = 0; i < rating; i++) ...[
                            Icon(
                              TennisIcons.star_filled,
                              size: 22,
                              color: AppColors().outYellow,
                            ),
                          ],
                          for (var i = 0; i < 5 - rating; i++) ...[
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                TennisIcons.star_empty,
                                size: 18,
                                color: AppColors().outYellow,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  Text(
                    description,
                    style: AppTextStyles().light_12_16.copyWith(
                          color: AppColors().secondaryText,
                        ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: info,
                        child: Text(
                          'Подробнее',
                          style: AppTextStyles().light_12_16.copyWith(
                                color: AppColors().secondaryText,
                              ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: call,
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
